{
  lib,
  stdenv,
  fetchurl,
}:
let
  version = "2026.5.29";

  platformMap = {
    "x86_64-linux" = "linux-x86_64";
    "aarch64-linux" = "linux-aarch64";
    "x86_64-darwin" = "macos-x86_64";
    "aarch64-darwin" = "macos-aarch64";
  };

  currentPlatform = platformMap.${stdenv.hostPlatform.system} or (throw "Unsupported system: ${stdenv.hostPlatform.system}");

  sources = {
    "x86_64-linux" = "sha256-lmxSTTgWUxNx6GV//ITED0fZTbifbHDoFq3OmD5tHwo=";
    "aarch64-linux" = "sha256-h9ShnDndGZ9tX0WzyA5WbUNJ0KKR5sxKyPVz4v7PoVI=";
    "x86_64-darwin" = "sha256-p2HBEh+zE9jiyLLzjdBkTTynAvEHR6rc+7Zb4WJu2jM=";
    "aarch64-darwin" = "sha256-BUypGbOSWSPxuDSytqbbeqcGODRq+yHly2Ff6IFMNE4=";
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
