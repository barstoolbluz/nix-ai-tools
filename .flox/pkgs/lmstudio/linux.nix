{
  appimageTools,
  fetchurl,
  lib,
  stdenv,
  graphicsmagick,
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

    # lms cli tool
    install -m 755 ${appimageContents}/resources/app/.webpack/lms $out/bin/

    patchelf --set-interpreter "${stdenv.cc.bintools.dynamicLinker}" \
    --set-rpath "${lib.getLib stdenv.cc.cc}/lib:${lib.getLib stdenv.cc.cc}/lib64:$out/lib:${
      lib.makeLibraryPath [ (lib.getLib stdenv.cc.cc) ]
    }" $out/bin/lms
  '';
}
