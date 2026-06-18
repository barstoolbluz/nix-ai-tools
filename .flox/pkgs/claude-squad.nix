{
  lib,
  stdenv,
  fetchurl,
  makeWrapper,
  tmux,
  git,
}:
let
  version = "1.0.19";

  platformMap = {
    "x86_64-linux" = "linux_amd64";
    "aarch64-linux" = "linux_arm64";
    "x86_64-darwin" = "darwin_amd64";
    "aarch64-darwin" = "darwin_arm64";
  };

  currentPlatform = platformMap.${stdenv.hostPlatform.system} or (throw "Unsupported system: ${stdenv.hostPlatform.system}");

  sources = {
    "x86_64-linux" = "sha256-js59LDdMhcQWJn5ItUJVKuDg3R1AMdPHi+YqE+//fmE=";
    "aarch64-linux" = "sha256-3snlmwBjSBv0IRi8cLBnGY+2YgzWKBjvlVYv2S42Hiw=";
    "x86_64-darwin" = "sha256-hAPoM5/ns4+jekUrmJBtNwnRwTDZq6s88PWqKfhwd+g=";
    "aarch64-darwin" = "sha256-vKzphj+mgG3Vn47i2WpeLjMz0/bWrPDj0SSHiCVbIXU=";
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
