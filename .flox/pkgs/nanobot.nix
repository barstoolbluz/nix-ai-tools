# Nanobot - Python-based AI agent, installed from PyPI via uv
# Uses a wrapper that bootstraps a venv on first run
{
  lib,
  stdenv,
  makeWrapper,
  python312,
  uv,
  nodejs,
}:
let
  version = "0.1.5";
in
stdenv.mkDerivation {
  pname = "nanobot";
  inherit version;

  dontUnpack = true;
  dontBuild = true;

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin $out/share/nanobot

    # Setup script: creates venv and installs nanobot-ai from PyPI
    cat > $out/bin/nanobot-setup << 'SETUP_EOF'
    #!/usr/bin/env bash
    set -euo pipefail
    NANOBOT_HOME="''${NANOBOT_HOME:-$HOME/.nanobot}"
    venv="$NANOBOT_HOME/venv"
    if [ ! -f "$venv/bin/nanobot" ]; then
      echo "Setting up nanobot v${version}..."
      mkdir -p "$NANOBOT_HOME"
      uv venv "$venv" --python python3
      uv pip install --python "$venv/bin/python" "nanobot-ai==${version}"
      echo "Setup complete."
    fi
    SETUP_EOF
    chmod +x $out/bin/nanobot-setup

    # Main wrapper: bootstraps venv if needed, then runs nanobot
    cat > $out/bin/nanobot << 'EOF'
    #!/usr/bin/env bash
    set -euo pipefail
    NANOBOT_HOME="''${NANOBOT_HOME:-$HOME/.nanobot}"
    venv="$NANOBOT_HOME/venv"
    if [ ! -f "$venv/bin/nanobot" ]; then
      nanobot-setup
    fi
    unset PYTHONPATH
    exec "$venv/bin/nanobot" "$@"
    EOF
    chmod +x $out/bin/nanobot

    runHook postInstall
  '';

  postFixup = ''
    for f in $out/bin/nanobot $out/bin/nanobot-setup; do
      wrapProgram "$f" \
        --prefix PATH : $out/bin:${lib.makeBinPath [ python312 uv nodejs ]}
    done
  '';

  meta = with lib; {
    description = "Nanobot - Ultra-lightweight personal AI agent";
    homepage = "https://github.com/HKUDS/nanobot";
    license = licenses.mit;
    sourceProvenance = with sourceTypes; [ fromSource ];
    platforms = platforms.unix;
    mainProgram = "nanobot";
  };
}
