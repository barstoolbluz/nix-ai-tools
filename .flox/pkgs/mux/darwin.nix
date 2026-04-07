{
  stdenv,
  fetchurl,
  undmg,
  meta,
  version,
  url,
  hash,
}:
stdenv.mkDerivation {
  inherit meta version;
  pname = "mux";

  src = fetchurl {
    inherit url hash;
  };

  nativeBuildInputs = [ undmg ];

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall
    mkdir -p $out/Applications
    cp -r *.app $out/Applications
    runHook postInstall
  '';

  dontFixup = true;
}
