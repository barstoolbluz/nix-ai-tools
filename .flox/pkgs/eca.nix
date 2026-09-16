{
  lib,
  stdenv,
  fetchurl,
  unzip,
}:
let
  version = "0.160.2";

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
    "x86_64-linux" = "sha256-5kdyREytoSZ8b7yjKIAKRIGVHEnVzPdgFFg4giUm0sg=";
    "aarch64-linux" = "sha256-0kNHAEncdCstFVIXI+h3KZIbAyy+Q7To4WyMAMw/iX0=";
    "x86_64-darwin" = "sha256-i0YGRgdTl3pNVbat3YedI4H00woZZcGCftvrkDlNFLU=";
    "aarch64-darwin" = "sha256-MDu4AtJBtwrIclHFx7oKEQabYIJmIcI4vHFjkkwClYg=";
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
