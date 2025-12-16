{
  buildGoModule,
  fetchFromGitHub,
  installShellFiles,
  lib,
}:
buildGoModule rec {
  pname = "crush";
  version = "0.22.0";

  src = fetchFromGitHub {
    owner = "charmbracelet";
    repo = "crush";
    rev = "v${version}";
    hash = "sha256-kBf68RB/iV5TGR4dUWe1nIgM9Y/hfYmkrjxgZkie4So=";
  };

  vendorHash = "sha256-TBpZ9gHpVvM+b94am49DvrevirxuoFmDr0Q6dwoY2Wk=";

  nativeBuildInputs = [ installShellFiles ];

  ldflags = [
    "-s"
    "-w"
    "-X=github.com/charmbracelet/crush/internal/version.Version=${version}"
  ];

  postInstall = ''
    # Generate shell completions
    installShellCompletion --cmd crush \
      --bash <($out/bin/crush completion bash) \
      --fish <($out/bin/crush completion fish) \
      --zsh <($out/bin/crush completion zsh)

    # Install JSON schema file
    install -Dm644 crush.json $out/share/crush/crush.json
  '';

  # Tests need API keys
  doCheck = false;

  meta = with lib; {
    description = "The glamourous AI coding agent for your favourite terminal";
    homepage = "https://github.com/charmbracelet/crush";
    license = licenses.mit;
    maintainers = with maintainers; [ zimbatm ];
    mainProgram = "crush";
  };
}