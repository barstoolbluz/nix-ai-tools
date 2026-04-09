{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  gcc-unwrapped,
}:
let
  version = "0.6.8";

  platformMap = {
    "x86_64-linux" = "x86_64-unknown-linux-gnu";
    "aarch64-linux" = "aarch64-unknown-linux-gnu";
    "aarch64-darwin" = "aarch64-apple-darwin";
  };

  currentPlatform = platformMap.${stdenv.hostPlatform.system} or (throw "Unsupported system: ${stdenv.hostPlatform.system}");

  sources = {
    "x86_64-linux" = "sha256-qgbUCej05b3BgW36RR8jvQHyUCm3Qxd1MsFm4/YgQ4I=";
    "aarch64-linux" = "sha256-u6+J4J0yPxKDPs2117lXtn52PTT3yRsbFutNuZbwjZg=";
    "aarch64-darwin" = "sha256-+5wcr96p746ocWfe4Q1zDprkfr14ZB+us0Zam3sgsYw=";
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
