{
  lib,
  stdenv,
  callPackage,
}:
let
  version = "0.27.1";

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
      hash = "sha256-sCHGGhk8ATv/6jjOo3dJtJCjuV7QAPSxKXyLVOH4AJQ=";
    };
    "aarch64-linux" = {
      url = "https://github.com/coder/mux/releases/download/v${version}/mux-${version}-arm64.AppImage";
      hash = "sha256-QLhD6koo8tej2ohoXpL9uuOQTHe0+xNXcFkL9mg3NWw=";
    };
    "x86_64-darwin" = {
      url = "https://github.com/coder/mux/releases/download/v${version}/mux-${version}-x64.dmg";
      hash = "sha256-Wc82uDlBD9fx7LL/Xj1GQjFznt0P1vD+tIhWMPxWnNM=";
    };
    "aarch64-darwin" = {
      url = "https://github.com/coder/mux/releases/download/v${version}/mux-${version}-arm64.dmg";
      hash = "sha256-kqtaqWUr0aIWFOA3FgSvkcDtnx67oo/0z6ByCawnujg=";
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
