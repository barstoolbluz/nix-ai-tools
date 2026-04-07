{
  stdenv,
  fetchurl,
  undmg,
  darwin,
  meta,
  version,
  url,
  hash,
}:
stdenv.mkDerivation {
  inherit meta version;
  pname = "lmstudio";

  src = fetchurl {
    inherit url hash;
  };

  nativeBuildInputs = [
    undmg
    darwin.sigtool
  ];

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall
    mkdir -p $out/Applications
    cp -r *.app $out/Applications

    # Bypass the /Applications path check in the main index.js
    local indexJs="$out/Applications/LM Studio.app/Contents/Resources/app/.webpack/main/index.js"
    substituteInPlace "$indexJs" --replace-quiet "'/Applications'" "'/'"

    # Re-sign the app bundle after patching
    /usr/bin/codesign --force --sign - "$out/Applications/LM Studio.app"

    runHook postInstall
  '';

  dontFixup = true;

  # undmg doesn't support APFS; use hdiutil directly
  unpackCmd = ''
    mnt=$(TMPDIR=/tmp mktemp -d -t nix-XXXXXXXXXX)
    function finish {
      /usr/bin/hdiutil detach $mnt -force
      rm -rf $mnt
    }
    trap finish EXIT
    /usr/bin/hdiutil attach -nobrowse -mountpoint $mnt $curSrc
    cp -a $mnt/LM\ Studio.app $PWD/
  '';
}
