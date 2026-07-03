{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  gcc-unwrapped,
  xorg,
}:
let
  version = "1.41.0";

  # Map Nix platforms to Goose platform naming
  platformMap = {
    "x86_64-linux" = {
      url = "https://github.com/block/goose/releases/download/v${version}/goose-x86_64-unknown-linux-gnu.tar.bz2";
      hash = "sha256-QW3llfPp58VKgivOBqeZYLk4fjzVGoMqPq34diN9Whw=";
    };
    "aarch64-linux" = {
      url = "https://github.com/block/goose/releases/download/v${version}/goose-aarch64-unknown-linux-gnu.tar.bz2";
      hash = "sha256-AfV7vsVqYu05A79GbUB+eEwRmqv6zmlfctP5FNyQ1BA=";
    };
    "x86_64-darwin" = {
      url = "https://github.com/block/goose/releases/download/v${version}/goose-x86_64-apple-darwin.tar.bz2";
      hash = "sha256-sDn+MO7MVOhcfcokfNlu0wZPoSNVFZXge5+DsMt+jBU=";
    };
    "aarch64-darwin" = {
      url = "https://github.com/block/goose/releases/download/v${version}/goose-aarch64-apple-darwin.tar.bz2";
      hash = "sha256-hOFFJz3FthAMOSzHZTdu510b83ou+en9nEL+4NLZl+g=";
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
