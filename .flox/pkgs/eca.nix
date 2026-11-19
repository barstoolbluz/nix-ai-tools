{
  lib,
  stdenv,
  fetchurl,
  unzip,
}:
let
  version = "0.172.0";

  # Map Nix platforms to ECA release naming
  platformMap = {
    "x86_64-linux" = "linux-amd64";
    "aarch64-linux" = "linux-aarch64";
    "x86_64-darwin" = "macos-amd64";
    "aarch64-darwin" = "macos-aarch64";
  };

  currentPlatform = platformMap.${stdenv.hostPlatform.system} or (throw "Unsupported system: ${stdenv.hostPlatform.system}");

  # Source hashes for each platform
  sources = {
    "x86_64-linux" = "sha256-lYG09lSRQpMVZeqhqxQSVUFMlwXVAKFPHbk19tTUXak=";
    "aarch64-linux" = "sha256-YD5fU9iSLIk/H6hS6pltg90xGWOFuRd5Yt/KTqV7ozQ=";
    "x86_64-darwin" = "sha256-pjz8raljp3Vo/MTWApLlpIODANnHjlqxRPEU9bwOlRI=";
    "aarch64-darwin" = "sha256-w1OQDGHq2MHGBxkCdSNmL7pjxXI7OV4k9aXvO19oBZk=";
  };
in
stdenv.mkDerivation {
  pname = "eca";
  inherit version;

  src = fetchurl {
    url = "https://github.com/editor-code-assistant/eca/releases/download/${version}/eca-native-${currentPlatform}.zip";
    hash = sources.${stdenv.hostPlatform.system} or (throw "Unsupported system: ${stdenv.hostPlatform.system}");
  };

  nativeBuildInputs = [ unzip ];

  unpackPhase = ''
    runHook preUnpack
    unzip $src
    runHook postUnpack
  '';

  dontBuild = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp eca $out/bin/eca
    chmod +x $out/bin/eca
    runHook postInstall
  '';

  meta = with lib; {
    description = "Editor Code Assistant (ECA) - AI pair programming capabilities agnostic of editor";
    homepage = "https://github.com/editor-code-assistant/eca";
    license = licenses.asl20;
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    platforms = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];
    mainProgram = "eca";
  };
}
