{
  lib,
  stdenv,
  callPackage,
}:
let
  upstreamVersion = "0.4.10-1";
  version = "${upstreamVersion}+fa40d6b";

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
      url = "https://installers.lmstudio.ai/linux/x64/${upstreamVersion}/LM-Studio-${upstreamVersion}-x64.AppImage";
      hash = "sha256-FC7rPA1CxTaYakpSSpjxYiPETW8+N5QmsmUib3RHD0o=";
    };
    "aarch64-linux" = {
      url = "https://installers.lmstudio.ai/linux/arm64/${upstreamVersion}/LM-Studio-${upstreamVersion}-arm64.AppImage";
      hash = "sha256-fo9jUmEtqu8bkfL1/v84IAp3RG0ua5g4hgieszhWOuM=";
    };
    "aarch64-darwin" = {
      url = "https://installers.lmstudio.ai/darwin/arm64/${upstreamVersion}/LM-Studio-${upstreamVersion}-arm64.dmg";
      hash = "sha256-LgaxbTXmiKyI/T8D+K+SLVzUgiQzOq/6JKEDwktrrDU=";
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
