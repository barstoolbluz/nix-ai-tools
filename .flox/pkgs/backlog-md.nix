{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
}:
let
  version = "1.51.0";

  # Map Nix platforms to backlog-md release naming
  platformMap = {
    "x86_64-linux" = "linux-x64-baseline";
    "aarch64-linux" = "linux-arm64";
    "x86_64-darwin" = "darwin-x64";
    "aarch64-darwin" = "darwin-arm64";
  };

  currentPlatform = platformMap.${stdenv.hostPlatform.system} or (throw "Unsupported system: ${stdenv.hostPlatform.system}");

  # Source hashes for each platform
  sources = {
    "x86_64-linux" = "sha256-4/HtM1Kv1aTkBk7HZT8DoFxSAcWnA7AyaCcX2Fa4Bgo=";
    "aarch64-linux" = "sha256-TAprif38UX5NCKF6zI1VaiOvlqai0tSXdODIkckw7BA=";
    "x86_64-darwin" = "sha256-LRHz8we0IFiH9xhq6Fv5kCP5fm8+j6iZugf9JKSiWWM=";
    "aarch64-darwin" = "sha256-+OzsHp50jbnM3fbscfv/BuQGvA2xBokefmD9GvJxNBU=";
  };

  src = fetchurl {
    url = "https://github.com/MrLesk/Backlog.md/releases/download/v${version}/backlog-bun-${currentPlatform}";
    hash = sources.${stdenv.hostPlatform.system} or (throw "Unsupported system: ${stdenv.hostPlatform.system}");
  };
in
stdenv.mkDerivation {
  pname = "backlog-md";
  inherit version;

  dontUnpack = true;

  nativeBuildInputs = lib.optionals stdenv.isLinux [
    autoPatchelfHook
  ];

  # Don't strip - bun compile embeds JavaScript in the executable
  dontStrip = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    install -m755 ${src} $out/bin/backlog
    runHook postInstall
  '';

  meta = with lib; {
    description = "Backlog.md - Project collaboration between humans and AI agents";
    homepage = "https://github.com/MrLesk/Backlog.md";
    changelog = "https://github.com/MrLesk/Backlog.md/releases";
    license = licenses.mit;
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    platforms = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];
    mainProgram = "backlog";
  };
}
