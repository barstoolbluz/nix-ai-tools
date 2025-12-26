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
  version = "0.29.1";

  src = fetchFromGitHub {
    owner = "charmbracelet";
    repo = "crush";
    rev = "v${version}";
    hash = "sha256-JR07IKU4saFjs4hrJ+6LDEeXV/3yk6tM7iNiey/85+8=";
  };

  vendorHash = "sha256-90fj92fENJuAQ7sQGK/f2Nk1LQ16tcOHYr+s5AW/JZ4=";

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