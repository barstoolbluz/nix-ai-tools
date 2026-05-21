{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  gcc-unwrapped,
  alsa-lib,
  openssl,
}:
let
  version = "0.1.4";

  platformMap = {
    "x86_64-linux" = "linux-x86_64";
    "aarch64-linux" = "linux-aarch64";
    "x86_64-darwin" = "macos-x86_64";
    "aarch64-darwin" = "macos-aarch64";
  };

  currentPlatform = platformMap.${stdenv.hostPlatform.system} or (throw "Unsupported system: ${stdenv.hostPlatform.system}");

  sources = {
    "x86_64-linux" = "sha256-EBI6n/dTcCXLAA5B4KShRKjkRB+dDuSLkMf3QTLpEF8=";
    "aarch64-linux" = "sha256-hEHWVTsqiKNw1ZRrBIfVs6P9S9oqdUv/Wehm890h3ow=";
    "x86_64-darwin" = "sha256-gPbMcttsAHDOxnmtYVWwz/GSOFkbATLOU2hRBLTEV/o=";
    "aarch64-darwin" = "sha256-5o8f0/owwp/peLuPSnr1F3QpOlXCiP47iVryfIzh0/w=";
  };
in
stdenv.mkDerivation {
  pname = "claurst";
  inherit version;

  src = fetchurl {
    url = "https://github.com/Kuberwastaken/claurst/releases/download/v${version}/claurst-${currentPlatform}.tar.gz";
    hash = sources.${stdenv.hostPlatform.system} or (throw "Unsupported system: ${stdenv.hostPlatform.system}");
  };

  sourceRoot = ".";

  nativeBuildInputs = lib.optionals stdenv.isLinux [
    autoPatchelfHook
  ];

  buildInputs = lib.optionals stdenv.isLinux [
    gcc-unwrapped.lib
    alsa-lib
    openssl
  ];

  # aarch64-linux binary links against OpenSSL 1.1 (EOL/insecure in nixpkgs)
  # while x86_64-linux uses OpenSSL 3. Ignore the 1.1 deps so the package builds.
  autoPatchelfIgnoreMissingDeps = [
    "libssl.so.1.1"
    "libcrypto.so.1.1"
  ];

  dontBuild = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    install -m755 claurst-${currentPlatform} $out/bin/claurst
    runHook postInstall
  '';

  meta = with lib; {
    description = "Claurst - Multi-provider terminal coding agent built in Rust";
    homepage = "https://github.com/Kuberwastaken/claurst";
    license = licenses.gpl3Only;
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    platforms = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];
    mainProgram = "claurst";
  };
}
