{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  gcc-unwrapped,
}:
let
  version = "0.8.2";

  platformMap = {
    "x86_64-linux" = "x86_64-unknown-linux-gnu";
    "aarch64-linux" = "aarch64-unknown-linux-gnu";
    "aarch64-darwin" = "aarch64-apple-darwin";
  };

  currentPlatform = platformMap.${stdenv.hostPlatform.system} or (throw "Unsupported system: ${stdenv.hostPlatform.system}");

  sources = {
    "x86_64-linux" = "sha256-a59+nZh3pWuG2dhZcGa5IXP/FiUslhpxRek+mg2a39k=";
    "aarch64-linux" = "sha256-05XMtX5tlMJqltVlGDt5ZfMm10EkRQO02sL6fDEk7BQ=";
    "aarch64-darwin" = "sha256-UGoyCl/mYF2hCIqA06sCsttZz6lHrwqD0lUJ0zcVug4=";
  };
in
stdenv.mkDerivation {
  pname = "zeroclaw";
  inherit version;

  src = fetchurl {
    url = "https://github.com/zeroclaw-labs/zeroclaw/releases/download/v${version}/zeroclaw-${currentPlatform}.tar.gz";
    hash = sources.${stdenv.hostPlatform.system} or (throw "Unsupported system: ${stdenv.hostPlatform.system}");
  };

  sourceRoot = ".";

  nativeBuildInputs = lib.optionals stdenv.isLinux [
    autoPatchelfHook
  ];

  buildInputs = lib.optionals stdenv.isLinux [
    gcc-unwrapped.lib
  ];

  dontBuild = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    install -m755 zeroclaw $out/bin/zeroclaw
    runHook postInstall
  '';

  meta = with lib; {
    description = "ZeroClaw - Personal AI assistant infrastructure, 100% Rust";
    homepage = "https://github.com/zeroclaw-labs/zeroclaw";
    license = with licenses; [ mit asl20 ];
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    platforms = [
      "x86_64-linux"
      "aarch64-linux"
      "aarch64-darwin"
    ];
    mainProgram = "zeroclaw";
  };
}
