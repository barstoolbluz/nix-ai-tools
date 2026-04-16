{
  appimageTools,
  fetchurl,
  lib,
  stdenv,
  graphicsmagick,
  makeWrapper,
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
  '';
}
