#!/usr/bin/env bash
set -euo pipefail

# Download new release artifacts, compute SRI hashes, and update .nix files.
#
# Usage: hash-update.sh <package-name> <new-version>
#
# Reads package metadata from .github/package-versions.json.
# Exits 0 on success, 1 on failure (caller should git checkout -- . to revert).

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
METADATA="$REPO_ROOT/.github/package-versions.json"

if [ $# -lt 2 ]; then
  echo "Usage: $0 <package-name> <new-version> [full-rev]"
  exit 1
fi

PKG="$1"
NEW_VERSION="$2"
FULL_REV="${3:-}"

output_var="${GITHUB_OUTPUT:-/dev/stdout}"

pkg_type=$(jq -r ".packages.\"$PKG\".type" "$METADATA")
version_file=$(jq -r ".packages.\"$PKG\".version_file" "$METADATA")
nix_file="$REPO_ROOT/$version_file"

if [ ! -f "$nix_file" ]; then
  echo "Error: $nix_file not found"
  exit 1
fi

echo "=== Updating $PKG to $NEW_VERSION ==="
echo "Type: $pkg_type"
echo "File: $version_file"
echo

# Convert a nix32 hash from nix-prefetch-url to SRI format
to_sri() {
  nix --extra-experimental-features nix-command hash convert --hash-algo sha256 --to sri "$1"
}

# Prefetch a URL and return the SRI hash
prefetch_url() {
  local url="$1"
  local nix32_hash
  echo "  Fetching: $url" >&2
  nix32_hash=$(nix-prefetch-url "$url" 2>/dev/null) || {
    echo "  FAILED to fetch: $url" >&2
    return 1
  }
  to_sri "$nix32_hash"
}

# Prefetch a URL with --unpack and return the SRI hash
prefetch_url_unpack() {
  local url="$1"
  local nix32_hash
  echo "  Fetching (unpack): $url" >&2
  nix32_hash=$(nix-prefetch-url --unpack "$url" 2>/dev/null) || {
    echo "  FAILED to fetch: $url" >&2
    return 1
  }
  to_sri "$nix32_hash"
}

# Resolve a URL template with substitutions
resolve_url() {
  local template="$1" version="$2" asset="$3"
  local owner repo
  owner=$(jq -r ".packages.\"$PKG\".github.owner" "$METADATA")
  repo=$(jq -r ".packages.\"$PKG\".github.repo" "$METADATA")

  echo "$template" \
    | sed "s|{version}|$version|g" \
    | sed "s|{owner}|$owner|g" \
    | sed "s|{repo}|$repo|g" \
    | sed "s|{asset}|$asset|g"
}

# --- Handler: upstream ---
update_upstream() {
  local owner repo
  owner=$(jq -r ".packages.\"$PKG\".github.owner" "$METADATA")
  repo=$(jq -r ".packages.\"$PKG\".github.repo" "$METADATA")

  if [ -z "$FULL_REV" ]; then
    echo "Error: upstream update requires full rev (pass as 3rd arg)"
    exit 1
  fi

  echo "Prefetching upstream source..."
  local url="https://github.com/$owner/$repo/archive/$FULL_REV.tar.gz"
  local new_hash
  new_hash=$(prefetch_url_unpack "$url") || exit 1
  echo "  New hash: $new_hash"

  # Update rev and hash in fetch-upstream.nix
  sed -i "s|rev = \"[^\"]*\"|rev = \"$FULL_REV\"|" "$nix_file"
  sed -i "s|hash = \"sha256-[^\"]*\"|hash = \"$new_hash\"|" "$nix_file"

  echo "Updated $version_file with rev=$FULL_REV"
}

# --- Handler: github-binary and custom-binary ---
update_binary() {
  local platforms url_template
  platforms=$(jq -r ".packages.\"$PKG\".platforms | keys[]" "$METADATA")

  # Determine if there are platform-specific URL templates
  local has_linux_template has_darwin_template
  has_linux_template=$(jq -r ".packages.\"$PKG\".url_template_linux // empty" "$METADATA")
  has_darwin_template=$(jq -r ".packages.\"$PKG\".url_template_darwin // empty" "$METADATA")
  url_template=$(jq -r ".packages.\"$PKG\".url_template // empty" "$METADATA")

  declare -A new_hashes

  echo "Prefetching binary hashes for $PKG $NEW_VERSION..."
  for nix_platform in $platforms; do
    local asset effective_template url new_hash
    asset=$(jq -r ".packages.\"$PKG\".platforms.\"$nix_platform\"" "$METADATA")

    # Pick the right URL template based on platform
    if [ -n "$has_linux_template" ] && [[ "$nix_platform" == *linux* ]]; then
      effective_template="$has_linux_template"
    elif [ -n "$has_darwin_template" ] && [[ "$nix_platform" == *darwin* ]]; then
      effective_template="$has_darwin_template"
    elif [ -n "$url_template" ]; then
      effective_template="$url_template"
    else
      echo "Error: no URL template for $PKG / $nix_platform"
      exit 1
    fi

    url=$(resolve_url "$effective_template" "$NEW_VERSION" "$asset")
    new_hash=$(prefetch_url "$url") || {
      echo "Error: failed to prefetch $nix_platform for $PKG — aborting entire package"
      exit 1
    }
    echo "  $nix_platform: $new_hash"
    new_hashes["$nix_platform"]="$new_hash"
  done

  echo
  echo "Updating $version_file..."

  # Update version string (first occurrence only)
  sed -i "0,/version = \"[^\"]*\"/{s/version = \"[^\"]*\"/version = \"$NEW_VERSION\"/}" "$nix_file"

  # Update per-platform hashes
  # Strategy: find the platform key as an anchor, then replace the hash on the same or nearby line
  for nix_platform in $platforms; do
    local hash="${new_hashes[$nix_platform]}"

    # Pattern 1: sources = { "x86_64-linux" = "sha256-..."; }
    # Pattern 2: sources = { "x86_64-linux" = { ... hash = "sha256-..."; } }
    # Pattern 3: hashes = { x86_64-linux = "sha256-..."; }

    # Try inline hash replacement (most common pattern)
    # Pattern 1: quoted key with inline hash — sources = { "x86_64-linux" = "sha256-..."; }
    if grep -qP "\"$nix_platform\"\s*=\s*\"sha256-" "$nix_file"; then
      sed -i "/\"$nix_platform\"/s|\"sha256-[^\"]*\"|\"$hash\"|" "$nix_file"
    # Pattern 2: unquoted key with inline hash — hashes = { x86_64-linux = "sha256-..."; }
    elif grep -qP "^\s*${nix_platform}\s*=\s*\"sha256-" "$nix_file"; then
      sed -i "/^[[:space:]]*${nix_platform}[[:space:]]*=/s|\"sha256-[^\"]*\"|\"$hash\"|" "$nix_file"
    # Pattern 3: quoted key with '=' (definition, not meta list), hash on a subsequent line
    # e.g. "x86_64-linux" = { url = "..."; hash = "sha256-..."; };
    elif grep -qP "\"$nix_platform\"\s*=" "$nix_file"; then
      awk -v plat="\"$nix_platform\"" -v hash="\"$hash\"" '
        $0 ~ plat && /=/ { found=1 }
        found && /hash[[:space:]]*=/ && /"sha256-/ {
          sub(/"sha256-[^"]*"/, hash)
          found=0
        }
        { print }
      ' "$nix_file" > "$nix_file.tmp" && mv "$nix_file.tmp" "$nix_file"
    # Pattern 4: unquoted key with '=', hash on a subsequent line
    # e.g. x86_64-linux = { url = "..."; hash = "sha256-..."; };
    elif grep -qP "^\s*${nix_platform}\s*=" "$nix_file"; then
      awk -v plat="$nix_platform" -v hash="\"$hash\"" '
        $0 ~ ("^[[:space:]]*" plat "[[:space:]]*=") { found=1 }
        found && /hash[[:space:]]*=/ && /"sha256-/ {
          sub(/"sha256-[^"]*"/, hash)
          found=0
        }
        { print }
      ' "$nix_file" > "$nix_file.tmp" && mv "$nix_file.tmp" "$nix_file"
    else
      echo "  Warning: could not find hash anchor for $nix_platform in $nix_file"
    fi
  done

  echo "Updated version and hashes in $version_file"
}

# --- Handler: github-source ---
update_source() {
  local owner repo tag_pattern tag
  owner=$(jq -r ".packages.\"$PKG\".github.owner" "$METADATA")
  repo=$(jq -r ".packages.\"$PKG\".github.repo" "$METADATA")
  tag_pattern=$(jq -r ".packages.\"$PKG\".tag_pattern" "$METADATA")

  # Build the tag from the pattern
  tag="${tag_pattern//\{version\}/$NEW_VERSION}"

  echo "Prefetching source for $PKG $NEW_VERSION (tag: $tag)..."
  local url="https://github.com/$owner/$repo/archive/refs/tags/$tag.tar.gz"
  local new_hash
  new_hash=$(prefetch_url_unpack "$url") || exit 1
  echo "  Source hash: $new_hash"

  # Update version (first occurrence only — some files have version = "..." in postPatch scripts)
  sed -i "0,/version = \"[^\"]*\"/{s/version = \"[^\"]*\"/version = \"$NEW_VERSION\"/}" "$nix_file"

  # Update source hash — look for hash right after fetchFromGitHub
  # The source hash is typically the first hash = "sha256-..." after the version
  # We need to update it specifically (not vendor/cargo/npm hashes)
  if grep -qP "tag\s*=\s*\"v" "$nix_file"; then
    # Uses tag = "v${version}" pattern (code-package.nix)
    sed -i "/fetchFromGitHub/,/};/{
      s|hash = \"sha256-[^\"]*\"|hash = \"$new_hash\"|
    }" "$nix_file"
  elif grep -qP "rev\s*=\s*\"v" "$nix_file"; then
    # Uses rev = "v${version}" pattern (crush.nix, nanocoder.nix)
    sed -i "/fetchFromGitHub/,/};/{
      s|hash = \"sha256-[^\"]*\"|hash = \"$new_hash\"|
    }" "$nix_file"
  else
    echo "Warning: could not identify source hash pattern in $nix_file"
    # Fallback: update the first hash
    sed -i "0,/hash = \"sha256-[^\"]*\"/{s|hash = \"sha256-[^\"]*\"|hash = \"$new_hash\"|}" "$nix_file"
  fi

  echo "Updated version and source hash in $version_file"

  # Vendor hash handling
  local has_vendor_hash has_npm_deps_hash
  has_vendor_hash=$(jq -r ".packages.\"$PKG\".has_vendor_hash // false" "$METADATA")
  has_npm_deps_hash=$(jq -r ".packages.\"$PKG\".has_npm_deps_hash // false" "$METADATA")

  if [ "$has_vendor_hash" = "true" ]; then
    echo
    echo "Package has vendorHash/cargoHash — setting to empty to trigger build failure..."
    # Set the vendor hash to a known-bad value so the build fails and prints the correct one
    sed -i 's/vendorHash = "sha256-[^"]*"/vendorHash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="/' "$nix_file"
    sed -i 's/cargoHash = "sha256-[^"]*"/cargoHash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="/' "$nix_file"
    echo "NOTE: A follow-up build is needed to obtain the correct vendor hash."
    echo "vendor-hash-needed=true" >>"$output_var"
  fi

  if [ "$has_npm_deps_hash" = "true" ]; then
    echo
    echo "Package has npmDepsHash/pnpmDeps hash — setting to empty to trigger build failure..."
    # Only replace hash inside fetchDeps/pnpmDeps blocks, not the fetchFromGitHub source hash
    sed -i '/fetchDeps\|pnpmDeps\|npmDeps/,/};/{
      s/hash = "sha256-[^"]*"/hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="/
    }' "$nix_file"
    echo "NOTE: A follow-up build is needed to obtain the correct npm deps hash."
    echo "npm-hash-needed=true" >>"$output_var"
  fi
}

# Dispatch based on package type
case "$pkg_type" in
  upstream)
    update_upstream
    ;;
  github-binary|custom-binary|desktop-app)
    update_binary
    ;;
  github-source)
    update_source
    ;;
  *)
    echo "Error: unknown package type '$pkg_type'"
    exit 1
    ;;
esac

echo
echo "=== Done ==="

# Verify the file was actually modified
if git -C "$REPO_ROOT" diff --quiet -- "$version_file"; then
  echo "Warning: no changes detected in $version_file"
  echo "updated=false" >>"$output_var"
else
  echo "Changes written to $version_file"
  echo "updated=true" >>"$output_var"
  echo "new_version=$NEW_VERSION" >>"$output_var"
fi
