{
  lib,
  stdenv,
  callPackage,
}:
let
  version = "0.24.0";

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
      hash = "sha256-+/kdcdRhzlKa+GdxqDAT0nGXN1M7htpeLjuW11rjQEU=";
    };
    "aarch64-linux" = {
      url = "https://github.com/coder/mux/releases/download/v${version}/mux-${version}-arm64.AppImage";
      hash = "sha256-YI1kGXMGvChmR5z+QMqFigaGtvz7LhKVfJKrDp2EgH0=";
    };
    "x86_64-darwin" = {
      url = "https://github.com/coder/mux/releases/download/v${version}/mux-${version}-x64.dmg";
      hash = "sha256-HoiC1RzOmle4aGiTASSrJg6OLgt+A+gMYLWaxR+oPMo=";
    };
    "aarch64-darwin" = {
      url = "https://github.com/coder/mux/releases/download/v${version}/mux-${version}-arm64.dmg";
      hash = "sha256-QwRk/1i+JiduwoGSw0KOCEX+Vm0Rrnc8jwWvc5CSfe8=";
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
