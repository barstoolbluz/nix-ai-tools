{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  gcc-unwrapped,
  xorg,
}:
let
  version = "1.45.0";

  # Map Nix platforms to Goose platform naming
  platformMap = {
    "x86_64-linux" = {
      url = "https://github.com/block/goose/releases/download/v${version}/goose-x86_64-unknown-linux-gnu.tar.bz2";
      hash = "sha256-7F2l8BjPaOpEaIfTDez4R1QgNf/PkVNtHRNO2UuyRAE=";
    };
    "aarch64-linux" = {
      url = "https://github.com/block/goose/releases/download/v${version}/goose-aarch64-unknown-linux-gnu.tar.bz2";
      hash = "sha256-VK+tjhYAaMsXacoq0+GeNuhHJ3XmjXvInMkOd3nFUtE=";
    };
    "x86_64-darwin" = {
      url = "https://github.com/block/goose/releases/download/v${version}/goose-x86_64-apple-darwin.tar.bz2";
      hash = "sha256-q0XIwUzhCilRsLHzFKI/KXwiBqEK8SGgHU40fMQEKrE=";
    };
    "aarch64-darwin" = {
      url = "https://github.com/block/goose/releases/download/v${version}/goose-aarch64-apple-darwin.tar.bz2";
      hash = "sha256-OhtBGX/2cMNrC2KF9BzNlJlm7gN5M/OMXhHJNWeZzlg=";
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
