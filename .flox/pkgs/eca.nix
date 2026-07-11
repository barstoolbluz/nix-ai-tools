{
  lib,
  stdenv,
  fetchurl,
  unzip,
}:
let
  version = "0.145.0";

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
    "x86_64-linux" = "sha256-TDRIGEgUGBLQGtAPfhsC3616rbR+TriJZQldCZRIcyI=";
    "aarch64-linux" = "sha256-5AluQ43k4ZlvRGroAeU43QEfPhzVkO07GssoKjLQFoc=";
    "x86_64-darwin" = "sha256-EAGJbvLcVUbK/K4Yv7gmeaLuL9ephcNEA+Uo8AwZlX8=";
    "aarch64-darwin" = "sha256-HJ0LpwIjH6RlC7y4rMJzPSEptvHEVTPTImf73NQri04=";
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
