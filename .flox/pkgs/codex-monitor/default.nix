{
  lib,
  stdenv,
  callPackage,
}:
let
  version = "0.7.67";

  meta = {
    description = "Codex Monitor - Desktop app for orchestrating Codex AI agents";
    homepage = "https://github.com/Dimillian/CodexMonitor";
    license = lib.licenses.mit;
    mainProgram = "codex-monitor";
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    platforms = [
      "x86_64-linux"
      "aarch64-linux"
      "aarch64-darwin"
    ];
  };

  sources = {
    "x86_64-linux" = {
      url = "https://github.com/Dimillian/CodexMonitor/releases/download/v${version}/Codex.Monitor_${version}_amd64.AppImage";
      hash = "sha256-aD0tc5Pm6TiQ5khspOzYFFkGwvpteAlS6thU9RpV2Bo=";
    };
    "aarch64-linux" = {
      url = "https://github.com/Dimillian/CodexMonitor/releases/download/v${version}/Codex.Monitor_${version}_aarch64.AppImage";
      hash = "sha256-4g3DPEJ5Knt65ngIk908OrVCZUKUIxCQKihPUMelqYM=";
    };
    "aarch64-darwin" = {
      url = "https://github.com/Dimillian/CodexMonitor/releases/download/v${version}/CodexMonitor_${version}_aarch64.dmg";
      hash = "sha256-z0RFsAEjEB43/eb6bUTVNW6cFgKsK/86tp6wab2MJ/A=";
    };
  };

  currentSource = sources.${stdenv.hostPlatform.system} or (throw "Unsupported system: ${stdenv.hostPlatform.system}");
in
if stdenv.hostPlatform.isDarwin then
  callPackage ./darwin.nix {
    inherit meta version;
    inherit (currentSource) url hash;
  }
else
  callPackage ./linux.nix {
    inherit meta version;
    inherit (currentSource) url hash;
  }
