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
  # Use our custom Go 1.26.0
  go_1_26_0 = callPackage ./go_1_26_0.nix {};

  # Override buildGoModule to use our Go 1.26.0
  buildGoModuleWithGo1260 = buildGoModule.override {
    go = go_1_26_0;
  };
in
buildGoModuleWithGo1260 rec {
  pname = "crush";
  version = "0.44.0";

  src = fetchFromGitHub {
    owner = "charmbracelet";
    repo = "crush";
    rev = "v${version}";
    hash = "sha256-UyK03jnD6A5/NO/evG56dbn8GyDyVSnfFgdxl5toH14=";
  };

  vendorHash = "sha256-f0cQEZrwo1diUdA4B8Xjm66Ws5l/nMLJoPP6Azsibvk=";

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