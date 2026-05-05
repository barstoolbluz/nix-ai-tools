{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  zlib,
}:
let
  version = "1.15.1";

  platformMap = {
    "x86_64-linux" = "linux-x86_64";
    "aarch64-linux" = "linux-arm64";
    "x86_64-darwin" = "macos-intel";
    "aarch64-darwin" = "macos-arm64";
  };

  currentPlatform = platformMap.${stdenv.hostPlatform.system} or (throw "Unsupported system: ${stdenv.hostPlatform.system}");

  sources = {
    "x86_64-linux" = "sha256-d1F2zEAsRFORLkJVuXhRHayIiP2/nOuB2MoOzEPKy1M=";
    "aarch64-linux" = "sha256-qPJK1Jsxzoi5BsOUip2a1bIg1nJ5H/70TnwNU2gdkHM=";
    "x86_64-darwin" = "sha256-pmHl+nqlA7whFw8lYJvHr+poT/L+LtUrKSQ84rW4YAU=";
    "aarch64-darwin" = "sha256-Xg6sEczaoTknTdIC3E38T2Dcx0ITAr/W9WDsD73AUtI=";
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
