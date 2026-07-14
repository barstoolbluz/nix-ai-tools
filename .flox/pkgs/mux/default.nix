{
  lib,
  stdenv,
  callPackage,
}:
let
  version = "0.28.0";

  meta = {
    description = "Mux - Desktop app for isolated, parallel agentic development";
    homepage = "https://mux.coder.com";
    license = lib.licenses.agpl3Only;
    mainProgram = "mux";
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    platforms = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];
  };

  sources = {
    "x86_64-linux" = {
      url = "https://github.com/coder/mux/releases/download/v${version}/mux-${version}-x86_64.AppImage";
      hash = "sha256-501mNesNCuFYjEoaoMoeyhR/ykKQQdDQ/FEYybZsGMU=";
    };
    "aarch64-linux" = {
      url = "https://github.com/coder/mux/releases/download/v${version}/mux-${version}-arm64.AppImage";
      hash = "sha256-m1S9qNgE/5o/EhiNi+4o+mPMCkXBsTD1zINCTfDwjnI=";
    };
    "x86_64-darwin" = {
      url = "https://github.com/coder/mux/releases/download/v${version}/mux-${version}-x64.dmg";
      hash = "sha256-SZBvzlZB1XG8qIgXN3rX2GexVB9+LDhiN2UZbv/cJuQ=";
    };
    "aarch64-darwin" = {
      url = "https://github.com/coder/mux/releases/download/v${version}/mux-${version}-arm64.dmg";
      hash = "sha256-MgQj2tLWwkjTMnwQLWxTj9ycXqC8BgqcS8n3lXISdG4=";
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
