{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  zlib,
}:
let
  version = "1.14.0";

  platformMap = {
    "x86_64-linux" = "linux-x86_64";
    "aarch64-linux" = "linux-arm64";
    "x86_64-darwin" = "macos-intel";
    "aarch64-darwin" = "macos-arm64";
  };

  currentPlatform = platformMap.${stdenv.hostPlatform.system} or (throw "Unsupported system: ${stdenv.hostPlatform.system}");

  sources = {
    "x86_64-linux" = "sha256-3fGfQBsfoZaakvYMjka5KGfEmny58wihFW2zeKsDigA=";
    "aarch64-linux" = "sha256-PGXUVWeNnnfeuDjHP2w6MsJBjlxxfpIG+TPchmk78J4=";
    "x86_64-darwin" = "sha256-eYUXjYppzXi1Z4X3bRSJlpqE6YVNnOqYryJX6BhAf3U=";
    "aarch64-darwin" = "sha256-03WAUd+XLinXdBx5nfvpq4S1ZRG9ON2Q7Wu/QU3dapw=";
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
