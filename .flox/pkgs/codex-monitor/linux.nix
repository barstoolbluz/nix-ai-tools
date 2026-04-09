{
  appimageTools,
  fetchurl,
  lib,
  version,
  url,
  hash,
  meta,
}:
let
  pname = "codex-monitor";

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

  extraInstallCommands = ''
    mkdir -p $out/share/applications

    # Install desktop file if present
    if [ -f ${appimageContents}/codex-monitor.desktop ]; then
      install -m 444 -D ${appimageContents}/codex-monitor.desktop -t $out/share/applications
      substituteInPlace $out/share/applications/codex-monitor.desktop \
        --replace-quiet 'Exec=AppRun --no-sandbox %U' 'Exec=codex-monitor' \
        --replace-quiet 'Exec=AppRun' 'Exec=codex-monitor'
    fi

    # Install icons if present
    if [ -d ${appimageContents}/usr/share/icons ]; then
      cp -r ${appimageContents}/usr/share/icons $out/share/
    fi
  '';
}
