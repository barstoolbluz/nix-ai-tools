{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  zlib,
}:
let
  version = "1.15.0";

  platformMap = {
    "x86_64-linux" = "linux-x86_64";
    "aarch64-linux" = "linux-arm64";
    "x86_64-darwin" = "macos-intel";
    "aarch64-darwin" = "macos-arm64";
  };

  currentPlatform = platformMap.${stdenv.hostPlatform.system} or (throw "Unsupported system: ${stdenv.hostPlatform.system}");

  sources = {
    "x86_64-linux" = "sha256-3Mf0fxo20X4Jh46KpFyLrAYfeypOY+umgggTmeHo4AI=";
    "aarch64-linux" = "sha256-byT2M69/04tfCtHSEwj2bsZPgRjR/k/11kaEB7GOpG4=";
    "x86_64-darwin" = "sha256-pUu9mUheH3Iekc5/6b1MC+PJxBlmEZ+C93Vzosq4xDY=";
    "aarch64-darwin" = "sha256-0DFpNThIex9qQnqeEuyr3vBfRx9zmNya0Bas6k0Bv+4=";
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
