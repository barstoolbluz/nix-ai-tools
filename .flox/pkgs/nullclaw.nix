{
  lib,
  stdenv,
  fetchurl,
}:
let
  version = "2026.4.9";

  platformMap = {
    "x86_64-linux" = "linux-x86_64";
    "aarch64-linux" = "linux-aarch64";
    "x86_64-darwin" = "macos-x86_64";
    "aarch64-darwin" = "macos-aarch64";
  };

  currentPlatform = platformMap.${stdenv.hostPlatform.system} or (throw "Unsupported system: ${stdenv.hostPlatform.system}");

  sources = {
    "x86_64-linux" = "sha256-4O3mt+mixwqOd1/RSDhV/cik5WG4zod5G/657n5mOlM=";
    "aarch64-linux" = "sha256-hmwZLmccYaZSTZJbcP6A7Z6OImACZJCGDcTCF1IbuYs=";
    "x86_64-darwin" = "sha256-3ek4tyMmSv8eOtnAAcjVLPbGnte2VrL9x1dKGisD5g8=";
    "aarch64-darwin" = "sha256-rcnSawazsl5urq23HZsoo1xA5sPfmuBZWa6UvqRv2jc=";
  };

  src = fetchurl {
    url = "https://github.com/nullclaw/nullclaw/releases/download/v${version}/nullclaw-${currentPlatform}.bin";
    hash = sources.${stdenv.hostPlatform.system} or (throw "Unsupported system: ${stdenv.hostPlatform.system}");
  };
in
stdenv.mkDerivation {
  pname = "nullclaw";
  inherit version;

  dontUnpack = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    install -m755 ${src} $out/bin/nullclaw
    runHook postInstall
  '';

  meta = with lib; {
    description = "Nullclaw - Fastest, smallest autonomous AI assistant infrastructure, written in Zig";
    homepage = "https://github.com/nullclaw/nullclaw";
    license = licenses.mit;
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    platforms = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];
    mainProgram = "nullclaw";
  };
}
