{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  gcc-unwrapped,
  xorg,
}:
let
  version = "1.46.0";

  # Map Nix platforms to Goose platform naming
  platformMap = {
    "x86_64-linux" = {
      url = "https://github.com/block/goose/releases/download/v${version}/goose-x86_64-unknown-linux-gnu.tar.bz2";
      hash = "sha256-oc9IVqdl0H1rlWiaU8e8oh/Mbm1lwN/QZPxwQFK4Wns=";
    };
    "aarch64-linux" = {
      url = "https://github.com/block/goose/releases/download/v${version}/goose-aarch64-unknown-linux-gnu.tar.bz2";
      hash = "sha256-tW2mWrEASDLOVSTtQOxvvji6hNrmVNCo64a+nZAIbPY=";
    };
    "x86_64-darwin" = {
      url = "https://github.com/block/goose/releases/download/v${version}/goose-x86_64-apple-darwin.tar.bz2";
      hash = "sha256-tbZvXUlmqsdJmMY0IMmLPiia5JjwwSBGOsC428KkAIM=";
    };
    "aarch64-darwin" = {
      url = "https://github.com/block/goose/releases/download/v${version}/goose-aarch64-apple-darwin.tar.bz2";
      hash = "sha256-3iY/sGg53jE0Xf8IrrqZm6FlsCPNPOx+w77yD29PfnM=";
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
