{
  buildGoModule,
  fetchFromGitHub,
  installShellFiles,
  lib,
}:
buildGoModule rec {
  pname = "crush";
  version = "0.21.0";

  src = fetchFromGitHub {
    owner = "charmbracelet";
    repo = "crush";
    rev = "v${version}";
    hash = "sha256-bkzz78IVfpl85P04GLHSQSIreyhD9tsv88bUS2ax/lA=";
  };

  vendorHash = "sha256-Y3IZLqUK9+G3MDRcQp8BqnpOROCMDZlsx52cHAenl8k=";

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