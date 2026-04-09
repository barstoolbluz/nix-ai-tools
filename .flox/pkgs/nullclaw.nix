{
  lib,
  stdenv,
  fetchurl,
}:
let
  version = "2026.4.7";

  platformMap = {
    "x86_64-linux" = "linux-x86_64";
    "aarch64-linux" = "linux-aarch64";
    "x86_64-darwin" = "macos-x86_64";
    "aarch64-darwin" = "macos-aarch64";
  };

  currentPlatform = platformMap.${stdenv.hostPlatform.system} or (throw "Unsupported system: ${stdenv.hostPlatform.system}");

  sources = {
    "x86_64-linux" = "sha256-ebEb+qm75r9xGpOh7SKoqQGjoyQ44kYeoDtliHwrf1I=";
    "aarch64-linux" = "sha256-EOLZKDWJu733YodkNyKaHON0bCcW/y2hkJwO25P8VYA=";
    "x86_64-darwin" = "sha256-NMCTb3PclUOddM+qb6I1em4xmxYcNApPNkpHjlP8T6k=";
    "aarch64-darwin" = "sha256-0sYmSE4flF9qmPiJurOFvpNaeH6RQYMoD0wnG+23VZo=";
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
