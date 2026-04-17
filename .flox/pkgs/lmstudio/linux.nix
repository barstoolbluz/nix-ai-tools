{
  appimageTools,
  fetchurl,
  lib,
  stdenv,
  graphicsmagick,
  makeWrapper,
  xorg-server,
  version,
  url,
  hash,
  meta,
}:
let
  pname = "lmstudio";

  src = fetchurl { inherit url hash; };

  appimageContents = appimageTools.extractType2 { inherit pname version src; };
in
appimageTools.wrapType2 {
  inherit
    meta
    pname
    version
    src
    ;

  nativeBuildInputs = [ graphicsmagick ];

  extraPkgs = pkgs: [ pkgs.ocl-icd ];

  extraInstallCommands = ''
    mkdir -p $out/share/applications

    # Setup icons
    src_icon="${appimageContents}/usr/share/icons/hicolor/0x0/apps/lm-studio.png"
    sizes=("16x16" "32x32" "48x48" "64x64" "128x128" "256x256")
    for size in "''${sizes[@]}"; do
      install -dm755 "$out/share/icons/hicolor/$size/apps"
      gm convert "$src_icon" -resize "$size" "$out/share/icons/hicolor/$size/apps/lm-studio.png"
    done

    install -m 444 -D ${appimageContents}/lm-studio.desktop -t $out/share/applications

    # Rename the main executable from lmstudio to lm-studio
    mv $out/bin/lmstudio $out/bin/lm-studio

    substituteInPlace $out/share/applications/lm-studio.desktop \
      --replace-fail 'Exec=AppRun --no-sandbox %U' 'Exec=lm-studio'

    # lms cli tool — this is a Bun single-executable binary with an embedded
    # JS bundle. patchelf corrupts embedded data blobs by shifting ELF section
    # offsets, and invoking via ld-linux breaks /proc/self/exe resolution that
    # Bun needs to locate its bundle. We use LD_LIBRARY_PATH instead.
    install -m 755 ${appimageContents}/resources/app/.webpack/lms $out/bin/.lms-unwrapped

    # GPU detection + dynamic linker wrapper
    cat > $out/bin/lms << WRAPPER
    #!/usr/bin/env bash
    # LM Studio requires NVIDIA (CUDA) or a Vulkan-capable discrete GPU.
    # The lms binary segfaults at startup on systems without one.
    has_gpu=false
    if command -v nvidia-smi &>/dev/null && nvidia-smi &>/dev/null; then
      has_gpu=true
    elif command -v vulkaninfo &>/dev/null && vulkaninfo --summary 2>/dev/null | grep -q 'deviceType.*DISCRETE'; then
      has_gpu=true
    fi

    if [ "\$has_gpu" = false ]; then
      echo "LM Studio requires a supported GPU (NVIDIA with CUDA, or discrete AMD/Intel with Vulkan)." >&2
      echo "No compatible GPU detected. The lms binary will segfault without one." >&2
      echo "" >&2
      echo "To bypass this check: LMS_SKIP_GPU_CHECK=1 lms [args...]" >&2
      [ "\''${LMS_SKIP_GPU_CHECK:-}" = "1" ] || exit 1
    fi

    export LD_LIBRARY_PATH="${lib.getLib stdenv.cc.cc}/lib:${lib.getLib stdenv.cc.cc}/lib64:$out/lib:${
        lib.makeLibraryPath [ (lib.getLib stdenv.cc.cc) ]
      }\''${LD_LIBRARY_PATH:+:\$LD_LIBRARY_PATH}"
    exec "$out/bin/.lms-unwrapped" "\$@"
    WRAPPER
    chmod +x $out/bin/lms

    # --- lms-service: headless LM Studio service launcher ---
    cat > $out/bin/lms-service << LMS_SERVICE
    #!/usr/bin/env bash
    set -euo pipefail

    # Ensure lms can find the Electron binary
    config_dir="\''${HOME}/.lmstudio/.internal"
    mkdir -p "\$config_dir"
    echo '{"installLocation":"$out/bin/lm-studio"}' > "\$config_dir/app-install-location.json"

    # Find a free display number for Xvfb
    display_num=99
    while [ -e "/tmp/.X\$display_num-lock" ] && [ "\$display_num" -lt 200 ]; do
      display_num=\$((display_num + 1))
    done
    export DISPLAY=":\$display_num"

    # Start Xvfb (Electron requires X even in headless mode)
    ${xorg-server}/bin/Xvfb "\$DISPLAY" -screen 0 1024x768x24 -nolisten tcp &
    xvfb_pid=\$!
    cleanup() {
      $out/bin/lms server stop 2>/dev/null || true
      $out/bin/lms daemon down 2>/dev/null || true
      kill "\$xvfb_pid" 2>/dev/null || true
    }
    trap cleanup EXIT

    # Give Xvfb a moment to start
    sleep 0.5

    # Clean stale daemon state
    $out/bin/lms daemon down 2>/dev/null || true

    # Set up logging
    log_dir="\''${LMS_LOG_DIR:-\$HOME/.lmstudio/logs}"
    mkdir -p "\$log_dir"

    # Start LM Studio app (bwrap daemonizes on Linux, parent exits)
    $out/bin/lm-studio --run-as-service >> "\$log_dir/lm-studio.log" 2>&1

    # Wait for app to initialize, then start the API server
    attempts=0
    while [ "\$attempts" -lt 30 ]; do
      if $out/bin/lms server start >> "\$log_dir/lm-studio.log" 2>&1; then
        echo "LM Studio API server started on DISPLAY=\$DISPLAY"
        break
      fi
      attempts=\$((attempts + 1))
      sleep 2
    done

    # Keep alive — Xvfb is our direct child; when the service is stopped,
    # the EXIT trap fires and cleans up
    wait \$xvfb_pid
    LMS_SERVICE
    chmod +x $out/bin/lms-service

    # --- lms-models: list loaded models ---
    cat > $out/bin/lms-models << 'LMS_MODELS'
    #!/usr/bin/env bash
    host="''${LMS_HOST:-127.0.0.1}"
    port="''${LMS_PORT:-1234}"
    url="http://$host:$port/v1/models"

    response=$(curl -sf "$url" 2>/dev/null) || {
      echo "Error: Could not reach LM Studio at $url" >&2
      exit 1
    }

    if command -v jq &>/dev/null; then
      echo "$response" | jq -r '.data[] | "\(.id)  (\(.object // "model"))"' 2>/dev/null || echo "$response"
    else
      echo "$response"
    fi
    LMS_MODELS
    chmod +x $out/bin/lms-models

    # --- lmstudio-health: health check ---
    cat > $out/bin/lmstudio-health << 'LMS_HEALTH'
    #!/usr/bin/env bash
    host="''${LMS_HOST:-127.0.0.1}"
    port="''${LMS_PORT:-1234}"
    url="http://$host:$port/v1/models"

    response=$(curl -sf "$url" 2>/dev/null) || {
      echo "UNHEALTHY: LM Studio not responding at $url" >&2
      exit 1
    }

    echo "HEALTHY: LM Studio responding at $url"
    if command -v jq &>/dev/null; then
      models=$(echo "$response" | jq -r '.data[].id' 2>/dev/null)
      if [ -n "$models" ]; then
        echo "Loaded models:"
        echo "$models" | sed 's/^/  - /'
      else
        echo "No models currently loaded."
      fi
    fi
    LMS_HEALTH
    chmod +x $out/bin/lmstudio-health
  '';
}
