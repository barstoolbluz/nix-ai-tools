{
  lib,
  stdenv,
  fetchurl,
  makeWrapper,
  tmux,
  git,
}:
let
  version = "1.0.20";

  platformMap = {
    "x86_64-linux" = "linux_amd64";
    "aarch64-linux" = "linux_arm64";
    "x86_64-darwin" = "darwin_amd64";
    "aarch64-darwin" = "darwin_arm64";
  };

  currentPlatform = platformMap.${stdenv.hostPlatform.system} or (throw "Unsupported system: ${stdenv.hostPlatform.system}");

  sources = {
    "x86_64-linux" = "sha256-QldKThcAEZd08h+0ztRd9PseC950ohMue8pTewUMSGM=";
    "aarch64-linux" = "sha256-kTnRktd/TTUgn35sgb62QmTdePhpM/ay7zVXS3qMcQI=";
    "x86_64-darwin" = "sha256-iUgBVCa8WHMr+h4JhtMdJh1mM7adJaHocnZGeUJXtn8=";
    "aarch64-darwin" = "sha256-e86nQ1q4fn9ybalZ6CURJhNiGSmqoBhI60t5msddga0=";
  };
in
stdenv.mkDerivation {
  pname = "claude-squad";
  inherit version;

  src = fetchurl {
    url = "https://github.com/smtg-ai/claude-squad/releases/download/v${version}/claude-squad_${version}_${currentPlatform}.tar.gz";
    hash = sources.${stdenv.hostPlatform.system} or (throw "Unsupported system: ${stdenv.hostPlatform.system}");
  };

  sourceRoot = ".";

  nativeBuildInputs = [ makeWrapper ];

  dontBuild = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    install -m755 claude-squad $out/bin/cs
    wrapProgram $out/bin/cs \
      --prefix PATH : ${lib.makeBinPath [ tmux git ]}
    runHook postInstall
  '';

  meta = with lib; {
    description = "Claude Squad - Manage multiple AI coding agents in parallel";
    homepage = "https://github.com/smtg-ai/claude-squad";
    license = licenses.agpl3Only;
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    platforms = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];
    mainProgram = "cs";
  };
}
