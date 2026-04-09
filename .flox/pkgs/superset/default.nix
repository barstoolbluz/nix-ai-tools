{
  lib,
  stdenv,
  callPackage,
}:
let
  version = "1.4.7";

  meta = {
    description = "Superset - Code editor for the AI agents era";
    homepage = "https://superset.sh";
    license = lib.licenses.elastic20;
    mainProgram = "superset";
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    platforms = [
      "x86_64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];
  };

  sources = {
    "x86_64-linux" = {
      url = "https://github.com/superset-sh/superset/releases/download/desktop-v${version}/superset-${version}-x86_64.AppImage";
      hash = "sha256-2lc6+EIYNe3+4KaBQi6DuN+lsEnAg9fgjGa5jdkVK+A=";
    };
    "x86_64-darwin" = {
      url = "https://github.com/superset-sh/superset/releases/download/desktop-v${version}/Superset-${version}.dmg";
      hash = "sha256-JZg9KEGV2BiBeGU61k7LhEEVyQ4CbangLvmZu7X6+LQ=";
    };
    "aarch64-darwin" = {
      url = "https://github.com/superset-sh/superset/releases/download/desktop-v${version}/Superset-${version}-arm64.dmg";
      hash = "sha256-7eEcyjSIaoC3o5fYvGbrB9j2Hf1h2W0gqeHrB5g1KdM=";
    };
  };

  currentSource = sources.${stdenv.hostPlatform.system} or (throw "Unsupported system: ${stdenv.hostPlatform.system}. No aarch64-linux build available.");
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
