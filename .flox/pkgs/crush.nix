{
  lib,
  stdenvNoCC,
  fetchurl,
  installShellFiles,
  autoPatchelfHook,
  gcc-unwrapped,
}:
let
  version = "0.30.3";

  sources = {
    x86_64-linux = {
      url = "https://github.com/charmbracelet/crush/releases/download/v${version}/crush_${version}_Linux_x86_64.tar.gz";
      hash = "sha256-ShKP4FonvMtZrz0J4XvAXpfad20PKQeod6A2RLWnakU=";
    };
    aarch64-linux = {
      url = "https://github.com/charmbracelet/crush/releases/download/v${version}/crush_${version}_Linux_arm64.tar.gz";
      hash = "sha256-ey2iYYpW9lRE++1lQbnJQ9FkACsvTT871L7PWCdfufA=";
    };
    x86_64-darwin = {
      url = "https://github.com/charmbracelet/crush/releases/download/v${version}/crush_${version}_Darwin_x86_64.tar.gz";
      hash = "sha256-k9JjjWWY9JVS5/gPTmIEkUFS6guLvcRBDpGANaAyMLA=";
    };
    aarch64-darwin = {
      url = "https://github.com/charmbracelet/crush/releases/download/v${version}/crush_${version}_Darwin_arm64.tar.gz";
      hash = "sha256-2HspdPT+Sp46uBfLazOMD0U4VJo+PQCOrGNi2Nj9VHQ=";
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
