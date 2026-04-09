{
  stdenv,
  fetchurl,
  meta,
  version,
  url,
  hash,
}:
stdenv.mkDerivation {
  inherit meta version;
  pname = "superset";

  src = fetchurl {
    inherit url hash;
  };

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall
    mkdir -p $out/Applications
    cp -r *.app $out/Applications
    runHook postInstall
  '';

  dontFixup = true;

  # DMG may use APFS; use hdiutil directly
  unpackCmd = ''
    mnt=$(TMPDIR=/tmp mktemp -d -t nix-XXXXXXXXXX)
    function finish {
      /usr/bin/hdiutil detach $mnt -force
      rm -rf $mnt
    }
    trap finish EXIT
    /usr/bin/hdiutil attach -nobrowse -mountpoint $mnt $curSrc
    cp -a $mnt/*.app $PWD/
  '';
}
