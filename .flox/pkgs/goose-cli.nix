{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  gcc-unwrapped,
  xorg,
}:
let
  version = "1.53.0";

  # Map Nix platforms to Goose platform naming
  platformMap = {
    "x86_64-linux" = {
      url = "https://github.com/block/goose/releases/download/v${version}/goose-x86_64-unknown-linux-gnu.tar.bz2";
      hash = "sha256-LQEMZt/UNIu0N7OpQAGIJGil2xqlVoWJIEgVIvV3Utc=";
    };
    "aarch64-linux" = {
      url = "https://github.com/block/goose/releases/download/v${version}/goose-aarch64-unknown-linux-gnu.tar.bz2";
      hash = "sha256-4VZ5l2ChdL+8XRREOqzvBkznWS+Qmdyc4Ew9t05yIks=";
    };
    "x86_64-darwin" = {
      url = "https://github.com/block/goose/releases/download/v${version}/goose-x86_64-apple-darwin.tar.bz2";
      hash = "sha256-XZauFJKU++2pMOaTFEvzM7vJwRIdlJ8e138XbrajX0k=";
    };
    "aarch64-darwin" = {
      url = "https://github.com/block/goose/releases/download/v${version}/goose-aarch64-apple-darwin.tar.bz2";
      hash = "sha256-Sc+c/WGV9VjQ2fOczWkSEwBLzLLGJuK0CyRAWf+dvbo=";
    };
  };

  # Get platform info for current system
  currentPlatform =
    platformMap.${stdenv.hostPlatform.system}
    or (throw "Unsupported system: ${stdenv.hostPlatform.system}");

  src = fetchurl {
    url = currentPlatform.url;
    hash = currentPlatform.hash;
  };
in
stdenv.mkDerivation {
  pname = "goose";
  inherit version;

  inherit src;

  nativeBuildInputs = lib.optionals stdenv.isLinux [
    autoPatchelfHook
  ];

  buildInputs = lib.optionals stdenv.isLinux [
    gcc-unwrapped.lib
    xorg.libxcb
  ];

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    install -m755 goose $out/bin/goose

    runHook postInstall
  '';

  meta = with lib; {
    description = "An AI agent that automates complex development tasks from start to finish";
    homepage = "https://github.com/block/goose";
    license = licenses.asl20;
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    platforms = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];
    mainProgram = "goose";
  };
}
