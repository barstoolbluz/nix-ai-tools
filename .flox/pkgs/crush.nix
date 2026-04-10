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
  # Use our custom Go 1.26.1
  go_1_26_1 = callPackage ./go_1_26_1.nix {};

  # Override buildGoModule to use our Go 1.26.1
  buildGoModuleWithGo1261 = buildGoModule.override {
    go = go_1_26_1;
  };
in
buildGoModuleWithGo1261 rec {
  pname = "crush";
  version = "0.56.0";

  src = fetchFromGitHub {
    owner = "charmbracelet";
    repo = "crush";
    rev = "v${version}";
    hash = "sha256-JtqgEI09kRg/uW/2fxMQL5+cmODO2y6aW1e5OXTH2LY=";
  };

  vendorHash = "sha256-n5pqIxN2TwiEWd3ZzFHqYSIKYPsMYAip3kDRx4ajuck=";

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