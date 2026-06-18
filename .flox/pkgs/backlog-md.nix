{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
}:
let
  version = "1.47.1";

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
    "x86_64-linux" = "sha256-TKuBto+Bk/G+fkzUvnB93LiI5qBqPUkDPI2aCF79Qks=";
    "aarch64-linux" = "sha256-UeP8GIEaVvOgeSVW9cA4HupG1x3epBaJ5wD+gXfX0YY=";
    "x86_64-darwin" = "sha256-hjD6sFkod+zQwTWLGKMd3RgSDv9p+FPFTNrWmZfZ49w=";
    "aarch64-darwin" = "sha256-5FN9Cfjb6izBXsiTHH1FPBB3r4O0Zk+2nHIQEZsFp4c=";
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
