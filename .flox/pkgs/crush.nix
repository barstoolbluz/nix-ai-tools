{
  stdenv,
  fetchurl,
  fetchFromGitHub,
  buildGoModule,
  callPackage,
  installShellFiles,
  lib,
}:
let
  # Use our custom Go 1.25.5
  go_1_25_5 = callPackage ./go_1_25_5.nix {};

  # Override buildGoModule to use our Go 1.25.5
  buildGoModuleWithGo1255 = buildGoModule.override {
    go = go_1_25_5;
  };
in
buildGoModuleWithGo1255 rec {
  pname = "crush";
  version = "0.36.0";

  src = fetchFromGitHub {
    owner = "charmbracelet";
    repo = "crush";
    rev = "v${version}";
    hash = "sha256-xitCvejiVts9kkvtcVwh/zaeWIzDj0jx9xQMh2h+9Ns=";
  };

  vendorHash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";

  nativeBuildInputs = [ installShellFiles ];

  ldflags = [
    "-s"
    "-w"
    "-X=github.com/charmbracelet/crush/internal/version.Version=v${version}"
  ];

  postInstall = ''
    # Generate shell completions
    installShellCompletion --cmd crush \
      --bash <($out/bin/crush completion bash) \
      --fish <($out/bin/crush completion fish) \
      --zsh <($out/bin/crush completion zsh)

    # Install JSON schema file if present
    if [ -f crush.json ]; then
      install -Dm644 crush.json $out/share/crush/crush.json
    fi
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