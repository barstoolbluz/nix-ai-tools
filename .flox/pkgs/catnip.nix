{
  lib,
  stdenv,
  fetchurl,
}:
let
  version = "0.12.1";

  # Map Nix platforms to catnip release naming
  platformMap = {
    "x86_64-linux" = "linux_amd64";
    "aarch64-linux" = "linux_arm64";
    "x86_64-darwin" = "darwin_amd64";
    "aarch64-darwin" = "darwin_arm64";
  };

  currentPlatform = platformMap.${stdenv.hostPlatform.system} or (throw "Unsupported system: ${stdenv.hostPlatform.system}");

  # Source hashes for each platform
  sources = {
    "x86_64-linux" = "sha256-tEYvPnhoWM3aeG5u/tTL7plchg8ijIq6hTx7D5Bav+A=";
    "aarch64-linux" = "sha256-d77CyanWQDnGKEu1SHxQ4obX7XAHTa0uHVwP8xWio7Y=";
    "x86_64-darwin" = "sha256-laICXlpO0tjzCqEnBsa+5If2X5Zv8s4BBv4NsZ3bgF0=";
    "aarch64-darwin" = "sha256-if50wwKwt+gAvEenKBrDzu/IguokuQ/T3hNL0TvWvvo=";
  };
in
stdenv.mkDerivation {
  pname = "catnip";
  inherit version;

  src = fetchurl {
    url = "https://github.com/wandb/catnip/releases/download/v${version}/catnip_${version}_${currentPlatform}.tar.gz";
    hash = sources.${stdenv.hostPlatform.system} or (throw "Unsupported system: ${stdenv.hostPlatform.system}");
  };

  sourceRoot = ".";

  dontBuild = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    install -m755 catnip $out/bin/catnip
    runHook postInstall
  '';

  meta = with lib; {
    description = "Developer environment for agentic programming";
    homepage = "https://github.com/wandb/catnip";
    license = licenses.asl20;
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    platforms = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];
    mainProgram = "catnip";
  };
}
