{
  lib,
  stdenv,
  callPackage,
}:
let
  version = "0.23.2";

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
      hash = "sha256-ggc0jchdiDkjDyrdyxiUo1hnV4qFE65ki5YWNh/J0mw=";
    };
    "aarch64-linux" = {
      url = "https://github.com/coder/mux/releases/download/v${version}/mux-${version}-arm64.AppImage";
      hash = "sha256-M5AszACYtfWq0454Cb/o7XsWyj7OlL4keq1/J0ncnfM=";
    };
    "x86_64-darwin" = {
      url = "https://github.com/coder/mux/releases/download/v${version}/mux-${version}-x64.dmg";
      hash = "sha256-+wy8ix2CdSXvu0FLX5Xa3sVLSAZgEr76ENfN7WPOgIM=";
    };
    "aarch64-darwin" = {
      url = "https://github.com/coder/mux/releases/download/v${version}/mux-${version}-arm64.dmg";
      hash = "sha256-S1lQy1Jn7YP9xoqVpPbOnkncjTSZS3RwQ8/1NHC9vBA=";
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
