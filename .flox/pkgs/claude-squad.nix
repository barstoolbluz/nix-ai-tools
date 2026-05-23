{
  lib,
  stdenv,
  fetchurl,
  makeWrapper,
  tmux,
  git,
}:
let
  version = "1.0.18";

  platformMap = {
    "x86_64-linux" = "linux_amd64";
    "aarch64-linux" = "linux_arm64";
    "x86_64-darwin" = "darwin_amd64";
    "aarch64-darwin" = "darwin_arm64";
  };

  currentPlatform = platformMap.${stdenv.hostPlatform.system} or (throw "Unsupported system: ${stdenv.hostPlatform.system}");

  sources = {
    "x86_64-linux" = "sha256-q4yw+HSvdZnusLtyqkZqB00YgUiph0W74xs+0YVf4pA=";
    "aarch64-linux" = "sha256-jYhFa2csgmmVHLjPN2f5QvJvhW3dErhBdD5FntfLbwA=";
    "x86_64-darwin" = "sha256-dwJK0GMq0jc4XeAE3IRKTTilmP12qWjgF9ttEWfDMc0=";
    "aarch64-darwin" = "sha256-sOzZKJhHKKLkA83g3QIRAUtrgMNq7Sb71DWQrTMpkhk=";
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
