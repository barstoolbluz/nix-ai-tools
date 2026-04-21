# Hermes Agent - bootstrap wrapper
# Installs hermes-agent via uv into a persistent venv on first run.
# Uses $FLOX_ENV_CACHE/hermes-agent inside Flox, else ~/.hermes.
{
  lib,
  stdenv,
  makeWrapper,
  python311,
  nodejs,
  uv,
  git,
  ripgrep,
  ffmpeg,
  gcc-unwrapped,
}:
let
  upstreamVersion = "0.10.0";
  tag = "2026.4.16";
  version = "${upstreamVersion}+57cbb83";

  bootstrap = ''
    #!/usr/bin/env bash
    set -euo pipefail

    HERMES_HOME="''${FLOX_ENV_CACHE:-''${XDG_DATA_HOME:-$HOME/.local/share}}/hermes-agent"
    HERMES_VENV="$HERMES_HOME/venv"
    HERMES_REPO="$HERMES_HOME/repo"
    HERMES_TAG="${tag}"
    HERMES_STAMP="$HERMES_HOME/.version"

    # Isolate from any outer Python environment
    unset PYTHONPATH PYTHONHOME VIRTUAL_ENV
    export UV_LINK_MODE=copy

    # Force reinstall with RESET=1 or --reset flag
    if [ "''${RESET:-}" = "1" ] || [ "''${1:-}" = "--reset" ]; then
      echo "Resetting hermes-agent environment..." >&2
      rm -rf "$HERMES_VENV" "$HERMES_REPO" "$HERMES_STAMP"
      [ "''${1:-}" = "--reset" ] && shift
    fi

    # Create or update the venv if needed
    if [ ! -f "$HERMES_STAMP" ] || [ "$(cat "$HERMES_STAMP")" != "$HERMES_TAG" ]; then
      echo "Installing hermes-agent $HERMES_TAG..." >&2
      mkdir -p "$HERMES_HOME"

      # Clone or update the repo
      if [ -d "$HERMES_REPO/.git" ]; then
        git -C "$HERMES_REPO" fetch --depth 1 origin "v$HERMES_TAG"
        git -C "$HERMES_REPO" checkout FETCH_HEAD
      else
        rm -rf "$HERMES_REPO"
        git clone --depth 1 --branch "v$HERMES_TAG" \
          https://github.com/NousResearch/hermes-agent.git "$HERMES_REPO"
      fi

      # Create venv and install
      uv venv --python python3.11 "$HERMES_VENV" 2>/dev/null
      uv pip install --python "$HERMES_VENV/bin/python" pip setuptools wheel >&2
      uv pip install --python "$HERMES_VENV/bin/python" -e "$HERMES_REPO[all]" >&2 || \
        uv pip install --python "$HERMES_VENV/bin/python" -e "$HERMES_REPO" >&2

      # Install Node.js deps if present
      if [ -f "$HERMES_REPO/package.json" ]; then
        (cd "$HERMES_REPO" && npm install --no-fund --no-audit) >&2 2>/dev/null || true
      fi

      echo "$HERMES_TAG" > "$HERMES_STAMP"
      echo "Done." >&2
    fi

    trap 'echo ""; exit 130' INT
    "$HERMES_VENV/bin/hermes" "$@"
  '';
in
stdenv.mkDerivation {
  pname = "hermes-agent";
  inherit version;

  dontUnpack = true;

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin $out/libexec/hermes-agent

    # Write bootstrap script
    cat > $out/libexec/hermes-agent/bootstrap.sh << 'SCRIPT'
    ${bootstrap}
    SCRIPT
    chmod +x $out/libexec/hermes-agent/bootstrap.sh

    # Wrap with runtime deps on PATH
    makeWrapper $out/libexec/hermes-agent/bootstrap.sh $out/bin/hermes \
      --prefix PATH : ${lib.makeBinPath [ python311 nodejs uv git ripgrep ffmpeg ]} \
      ${lib.optionalString stdenv.isLinux "--prefix LD_LIBRARY_PATH : ${gcc-unwrapped.lib}/lib"}

    runHook postInstall
  '';

  meta = {
    description = "Self-improving AI agent with persistent learning from Nous Research";
    homepage = "https://github.com/NousResearch/hermes-agent";
    license = lib.licenses.mit;
    platforms = lib.platforms.unix;
    mainProgram = "hermes";
  };
}
