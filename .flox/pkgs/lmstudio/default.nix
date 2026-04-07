{
  lib,
  stdenv,
  callPackage,
}:
let
  version = "0.4.9-1";

  meta = {
    description = "LM Studio - Desktop app for experimenting with local and open-source LLMs";
    homepage = "https://lmstudio.ai/";
    license = lib.licenses.unfree;
    mainProgram = "lm-studio";
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    platforms = [
      "x86_64-linux"
      "aarch64-linux"
      "aarch64-darwin"
    ];
  };

  sources = {
    "x86_64-linux" = {
      url = "https://installers.lmstudio.ai/linux/x64/${version}/LM-Studio-${version}-x64.AppImage";
      hash = "sha256-+vn8gExfdfbYUBVzc59kCDlw7nEbFIyGR0fF9sFFodo=";
    };
    "aarch64-linux" = {
      url = "https://installers.lmstudio.ai/linux/arm64/${version}/LM-Studio-${version}-arm64.AppImage";
      hash = "sha256-fQgXmhkbqTjbW/pyPvyZsIxtkQanpgh1DkzyrbFH6t8=";
    };
    "aarch64-darwin" = {
      url = "https://installers.lmstudio.ai/darwin/arm64/${version}/LM-Studio-${version}-arm64.dmg";
      hash = "sha256-MuvYJ5mVC6Usz37DF/TG4M8gOHsKG2uN9qzq+dXNa7M=";
    };
  };

  currentSource = sources.${stdenv.hostPlatform.system} or (throw "Unsupported system: ${stdenv.hostPlatform.system}. LM Studio does not support x86_64-darwin.");
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
