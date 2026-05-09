{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  zlib,
}:
let
  version = "1.16.0";

  platformMap = {
    "x86_64-linux" = "linux-x86_64";
    "aarch64-linux" = "linux-arm64";
    "x86_64-darwin" = "macos-intel";
    "aarch64-darwin" = "macos-arm64";
  };

  currentPlatform = platformMap.${stdenv.hostPlatform.system} or (throw "Unsupported system: ${stdenv.hostPlatform.system}");

  sources = {
    "x86_64-linux" = "sha256-ywTuLakcaYcz1SAcVcvAjYHczJ1ktmYnWr9opODFkOM=";
    "aarch64-linux" = "sha256-Z8XPuU5f1MQSDrA2Cw8jM32jH2SnDoSWvPAI5Mrupq8=";
    "x86_64-darwin" = "sha256-SYTb15YEXNEqerjgi9DJ6xmO5Yzl8aCxBSuwbW1sy+E=";
    "aarch64-darwin" = "sha256-+iODMKRS8vHpM6/7ft/9pDwB8evYQZTsxWTFpqMGMX8=";
  };

  src = fetchurl {
    url = "https://github.com/OpenHands/OpenHands-CLI/releases/download/${version}/openhands-${currentPlatform}";
    hash = sources.${stdenv.hostPlatform.system} or (throw "Unsupported system: ${stdenv.hostPlatform.system}");
  };
in
stdenv.mkDerivation {
  pname = "openhands";
  inherit version;

  dontUnpack = true;
  dontBuild = true;

  nativeBuildInputs = lib.optionals stdenv.isLinux [
    autoPatchelfHook
  ];

  buildInputs = lib.optionals stdenv.isLinux [
    zlib
  ];

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    install -m755 ${src} $out/bin/openhands
    runHook postInstall
  '';

  meta = with lib; {
    description = "OpenHands CLI - AI-driven software development agent";
    homepage = "https://github.com/All-Hands-AI/OpenHands";
    license = licenses.mit;
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    platforms = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];
    mainProgram = "openhands";
  };
}
