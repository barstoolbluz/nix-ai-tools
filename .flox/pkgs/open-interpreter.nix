# Open Interpreter - bootstrap wrapper
# Installs open-interpreter via uv into a persistent venv on first run.
# Uses $FLOX_ENV_CACHE/open-interpreter inside Flox, else ~/.local/share/open-interpreter.
{
  lib,
  stdenv,
  makeWrapper,
  python312,
  nodejs,
  uv,
  git,
  gcc-unwrapped,
}:
let
  version = "0.4.3-1";

  bootstrap = ''
    #!/usr/bin/env bash
    set -euo pipefail

    OI_HOME="''${FLOX_ENV_CACHE:-''${XDG_DATA_HOME:-$HOME/.local/share}}/open-interpreter"
    OI_VENV="$OI_HOME/venv"
    OI_VERSION="${version}"
    OI_STAMP="$OI_HOME/.version"

    # Isolate from any outer Python environment
    unset PYTHONPATH PYTHONHOME VIRTUAL_ENV

    # Create or update the venv if needed
    if [ ! -f "$OI_STAMP" ] || [ "$(cat "$OI_STAMP")" != "$OI_VERSION" ]; then
      echo "Installing open-interpreter $OI_VERSION..." >&2
      mkdir -p "$OI_HOME"
      uv venv --python python3.12 "$OI_VENV" 2>/dev/null
      uv pip install --python "$OI_VENV/bin/python" "open-interpreter==$OI_VERSION" "setuptools<81" >&2
      echo "$OI_VERSION" > "$OI_STAMP"
      echo "Done." >&2
    fi

    exec "$OI_VENV/bin/interpreter" "$@"
  '';
in
stdenv.mkDerivation {
  pname = "open-interpreter";
  inherit version;

  dontUnpack = true;

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin $out/libexec/open-interpreter

    # Write bootstrap script
    cat > $out/libexec/open-interpreter/bootstrap.sh << 'SCRIPT'
    ${bootstrap}
    SCRIPT
    chmod +x $out/libexec/open-interpreter/bootstrap.sh

    # Wrap with runtime deps on PATH
    makeWrapper $out/libexec/open-interpreter/bootstrap.sh $out/bin/interpreter \
      --prefix PATH : ${lib.makeBinPath [ python312 nodejs uv git ]} \
      ${lib.optionalString stdenv.isLinux "--prefix LD_LIBRARY_PATH : ${gcc-unwrapped.lib}/lib"}

    # Aliases
    ln -s $out/bin/interpreter $out/bin/i

    runHook postInstall
  '';

  meta = {
    description = "Open Interpreter - A natural language interface for computers";
    homepage = "https://github.com/OpenInterpreter/open-interpreter";
    license = lib.licenses.agpl3Only;
    platforms = lib.platforms.unix;
    mainProgram = "interpreter";
  };
}
