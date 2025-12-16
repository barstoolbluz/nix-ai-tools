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
  version = "0.25.0";

  src = fetchFromGitHub {
    owner = "charmbracelet";
    repo = "crush";
    rev = "v${version}";
    hash = "sha256-CYzoSfvE2lTWHD/qR6NYNdsDmu1x0ONi7WktTDB7b94=";
  };

  vendorHash = "sha256-fKV3fNu1P5oX40i6Y4hIgr5cOtIgd5kW1vlSZ5fc91k=";

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