#!/usr/bin/env bash
set -euo pipefail

# Query GitHub API for latest releases, compare against current versions in .nix files.
# Outputs a JSON matrix of packages needing updates.
#
# Environment:
#   GITHUB_TOKEN  — required for API rate limits
#   PACKAGE_FILTER — optional space-separated list of package names to check (empty = all)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
METADATA="$REPO_ROOT/.github/package-versions.json"

if [ ! -f "$METADATA" ]; then
  echo "Error: $METADATA not found"
  exit 1
fi

PACKAGE_FILTER="${PACKAGE_FILTER:-}"

# Extract the current version from a .nix file
# Optional second arg: field name (default "version")
get_current_version() {
  local file="$REPO_ROOT/$1"
  local field="${2:-version}"
  if [ ! -f "$file" ]; then
    echo ""
    return
  fi
  grep -oP "${field}"'\s*=\s*"\K[^"]+' "$file" | head -1
}

# Extract the latest version from a GitHub release tag
get_latest_version() {
  local owner="$1" repo="$2" tag_pattern="$3"
  local tag

  tag=$(gh api "repos/$owner/$repo/releases/latest" --jq '.tag_name' 2>/dev/null) || {
    echo ""
    return
  }

  # Strip the tag pattern prefix to get the version
  # tag_pattern examples: "v{version}", "ironclaw-v{version}", "{version}"
  local prefix="${tag_pattern%%\{version\}*}"
  local suffix="${tag_pattern##*\{version\}}"
  local version="$tag"

  # Remove prefix
  if [ -n "$prefix" ]; then
    version="${version#"$prefix"}"
  fi
  # Remove suffix
  if [ -n "$suffix" ]; then
    version="${version%"$suffix"}"
  fi

  echo "$version"
}

# Get latest commit for upstream repo
get_latest_commit() {
  local owner="$1" repo="$2"
  gh api "repos/$owner/$repo/commits/main" --jq '.sha' 2>/dev/null || echo ""
}

echo "=== Package Version Check ==="
echo "Filter: ${PACKAGE_FILTER:-<all>}"
echo

declare -a matrix_items=()
declare -i checked=0 outdated=0 skipped=0 errors=0

# Read all package names from the metadata file
package_names=$(jq -r '.packages | keys[]' "$METADATA")

for pkg in $package_names; do
  # Apply filter if set
  if [ -n "$PACKAGE_FILTER" ]; then
    if ! echo "$PACKAGE_FILTER" | grep -qFw "$pkg"; then
      continue
    fi
  fi

  # Check if package is skipped
  is_skipped=$(jq -r ".packages.\"$pkg\".skip // false" "$METADATA")
  if [ "$is_skipped" = "true" ]; then
    skip_reason=$(jq -r ".packages.\"$pkg\".skip_reason // \"no API\"" "$METADATA")
    echo "SKIP $pkg — $skip_reason"
    skipped=$((skipped + 1))
    continue
  fi

  pkg_type=$(jq -r ".packages.\"$pkg\".type" "$METADATA")
  version_file=$(jq -r ".packages.\"$pkg\".version_file" "$METADATA")

  # Handle upstream type differently
  if [ "$pkg_type" = "upstream" ]; then
    owner=$(jq -r ".packages.\"$pkg\".github.owner" "$METADATA")
    repo=$(jq -r ".packages.\"$pkg\".github.repo" "$METADATA")

    current_rev=$(grep -oP "rev\s*=\s*\"\K[^\"]+" "$REPO_ROOT/$version_file" 2>/dev/null || echo "")
    latest_rev=$(get_latest_commit "$owner" "$repo")

    checked=$((checked + 1))

    if [ -z "$latest_rev" ]; then
      echo "ERROR $pkg — failed to query latest commit"
      errors=$((errors + 1))
      continue
    fi

    if [ "$current_rev" = "$latest_rev" ]; then
      echo "OK    $pkg — upstream rev ${current_rev:0:8} is current"
    else
      echo "UPDATE $pkg — upstream ${current_rev:0:8} -> ${latest_rev:0:8}"
      outdated=$((outdated + 1))
      matrix_items+=("{\"name\":\"$pkg\",\"type\":\"$pkg_type\",\"current_version\":\"${current_rev:0:8}\",\"new_version\":\"${latest_rev:0:8}\",\"full_rev\":\"$latest_rev\",\"version_file\":\"$version_file\"}")
    fi
    continue
  fi

  # Standard packages — check GitHub releases
  owner=$(jq -r ".packages.\"$pkg\".github.owner" "$METADATA")
  repo=$(jq -r ".packages.\"$pkg\".github.repo" "$METADATA")
  tag_pattern=$(jq -r ".packages.\"$pkg\".tag_pattern" "$METADATA")

  version_field=$(jq -r ".packages.\"$pkg\".version_field // \"version\"" "$METADATA")
  current_version=$(get_current_version "$version_file" "$version_field")
  if [ -z "$current_version" ]; then
    echo "ERROR $pkg — could not read $version_field from $version_file"
    errors=$((errors + 1))
    continue
  fi

  latest_version=$(get_latest_version "$owner" "$repo" "$tag_pattern")
  checked=$((checked + 1))

  if [ -z "$latest_version" ]; then
    echo "ERROR $pkg — failed to query latest release from $owner/$repo"
    errors=$((errors + 1))
    continue
  fi

  if [ "$current_version" = "$latest_version" ]; then
    echo "OK    $pkg — $current_version is current"
  else
    echo "UPDATE $pkg — $current_version -> $latest_version"
    outdated=$((outdated + 1))
    matrix_items+=("{\"name\":\"$pkg\",\"type\":\"$pkg_type\",\"current_version\":\"$current_version\",\"new_version\":\"$latest_version\",\"version_file\":\"$version_file\"}")
  fi
done

echo
echo "=== Summary ==="
echo "Checked: $checked | Outdated: $outdated | Skipped: $skipped | Errors: $errors"

# Build the matrix JSON
if [ ${#matrix_items[@]} -eq 0 ]; then
  matrix='{"include":[]}'
  has_updates="false"
else
  matrix_json='{"include":['
  for i in "${!matrix_items[@]}"; do
    if [ "$i" -gt 0 ]; then
      matrix_json+=","
    fi
    matrix_json+="${matrix_items[$i]}"
  done
  matrix_json+="]}"
  matrix="$matrix_json"
  has_updates="true"
fi

# Output for GitHub Actions
if [ -n "${GITHUB_OUTPUT:-}" ]; then
  echo "matrix=$matrix" >>"$GITHUB_OUTPUT"
  echo "has-updates=$has_updates" >>"$GITHUB_OUTPUT"
else
  echo
  echo "=== GitHub Actions Output ==="
  echo "matrix=$matrix"
  echo "has-updates=$has_updates"
  echo
  echo "=== Pretty Matrix ==="
  echo "$matrix" | jq .
fi
