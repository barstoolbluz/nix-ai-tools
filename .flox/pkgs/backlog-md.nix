{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
}:
let
  version = "1.46.0";

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
    "x86_64-linux" = "sha256-1UQHuAEAPIUb+vRzLpVPoonhAh0LDC+rm5TDCL3jnf8=";
    "aarch64-linux" = "sha256-waOl/U7WTe82sNoN461nW2mw1VdmOkIQZveJz1KysC8=";
    "x86_64-darwin" = "sha256-xclmmF5TBe3ySllrpTmHKmRpQA7Pkms0FWww3ovcPWc=";
    "aarch64-darwin" = "sha256-7XHX3DQX/yCWHHl/8KNOExQbNi4w4CD9wW8zHeRpxyA=";
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
