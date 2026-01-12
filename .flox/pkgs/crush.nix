{
  lib,
  stdenvNoCC,
  fetchurl,
  installShellFiles,
  autoPatchelfHook,
  gcc-unwrapped,
}:
let
  version = "0.31.0";

  sources = {
    x86_64-linux = {
      url = "https://github.com/charmbracelet/crush/releases/download/v${version}/crush_${version}_Linux_x86_64.tar.gz";
      hash = "sha256-SO7Zps7rTQVp553K8mRbsiGaw7KeIRE6jOBTkThuqUs=";
    };
    aarch64-linux = {
      url = "https://github.com/charmbracelet/crush/releases/download/v${version}/crush_${version}_Linux_arm64.tar.gz";
      hash = "sha256-7jTXfwk0RcfTu0GKZteDti9oi7ajLpWUWMOPrkudYNA=";
    };
    x86_64-darwin = {
      url = "https://github.com/charmbracelet/crush/releases/download/v${version}/crush_${version}_Darwin_x86_64.tar.gz";
      hash = "sha256-PJ1xPvfNN/FHe9OgjJEGuMu9734cQJzvi8ElgDqg10k=";
    };
    aarch64-darwin = {
      url = "https://github.com/charmbracelet/crush/releases/download/v${version}/crush_${version}_Darwin_arm64.tar.gz";
      hash = "sha256-JEKTH4KtiPbHYAQqLfHSKlO6/U6yIIbXHQ/KYp1a1r8=";
    };
  };

  source = sources.${stdenvNoCC.hostPlatform.system} or (throw "Unsupported system: ${stdenvNoCC.hostPlatform.system}");
in
stdenvNoCC.mkDerivation {
  pname = "crush";
  inherit version;

  src = fetchurl source;

  nativeBuildInputs = [
    installShellFiles
  ] ++ lib.optionals stdenvNoCC.isLinux [
    autoPatchelfHook
  ];

  buildInputs = lib.optionals stdenvNoCC.isLinux [
    gcc-unwrapped.lib
  ];

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    install -Dm755 crush $out/bin/crush

    # Install provided completions
    installShellCompletion --cmd crush \
      --bash completions/crush.bash \
      --fish completions/crush.fish \
      --zsh completions/crush.zsh

    # Install man page
    install -Dm644 manpages/crush.1.gz $out/share/man/man1/crush.1.gz

    # Install JSON schema if present
    if [ -f crush.json ]; then
      install -Dm644 crush.json $out/share/crush/crush.json
    fi

    runHook postInstall
  '';

  meta = with lib; {
    description = "The glamourous AI coding agent for your favourite terminal";
    homepage = "https://github.com/charmbracelet/crush";
    license = licenses.mit;
    maintainers = with maintainers; [ zimbatm ];
    mainProgram = "crush";
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
  };
}
