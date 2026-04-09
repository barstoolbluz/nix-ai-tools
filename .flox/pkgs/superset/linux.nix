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
  pname = "superset";

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

    if [ -f ${appimageContents}/superset.desktop ]; then
      install -m 444 -D ${appimageContents}/superset.desktop -t $out/share/applications
      substituteInPlace $out/share/applications/superset.desktop \
        --replace-quiet 'Exec=AppRun --no-sandbox %U' 'Exec=superset' \
        --replace-quiet 'Exec=AppRun' 'Exec=superset'
    fi

    if [ -d ${appimageContents}/usr/share/icons ]; then
      cp -r ${appimageContents}/usr/share/icons $out/share/
    fi
  '';
}
