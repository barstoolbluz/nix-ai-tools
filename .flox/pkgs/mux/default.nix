{
  lib,
  stdenv,
  callPackage,
}:
let
  version = "0.23.1";

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
      hash = "sha256-R7FiI2W7ibdDRJxcwIK60r/3UTnZH8OygkBzWJ9ONPg=";
    };
    "aarch64-linux" = {
      url = "https://github.com/coder/mux/releases/download/v${version}/mux-${version}-arm64.AppImage";
      hash = "sha256-o/6u6Ie5v5D8eI/BFbcSAvOzlTsgo+J2lGHSmm8NAec=";
    };
    "x86_64-darwin" = {
      url = "https://github.com/coder/mux/releases/download/v${version}/mux-${version}-x64.dmg";
      hash = "sha256-H7nttOI8AAZluJs0PUH7w52NyIjqF/1dSNRpEg65h5A=";
    };
    "aarch64-darwin" = {
      url = "https://github.com/coder/mux/releases/download/v${version}/mux-${version}-arm64.dmg";
      hash = "sha256-8XNTAdkyhf3c/quBlV9gPlBLQqKG80Rnoljib1urJ2w=";
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
