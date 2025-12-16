{
  lib,
  stdenv,
  fetchFromGitHub,
  installShellFiles,
  rustPlatform,
  pkg-config,
  openssl,
  installShellCompletions ? stdenv.buildPlatform.canExecute stdenv.hostPlatform,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "code";
  version = "0.6.6";

  src = fetchFromGitHub {
    owner = "just-every";
    repo = "code";
    tag = "v${finalAttrs.version}";
    hash = "sha256-c5NamyrBfacK8GrtXMidSOrNiuY4N2mSsb0xd6FdSgg=";
  };

  sourceRoot = "${finalAttrs.src.name}/code-rs";

  cargoHash = "sha256-oNrBwI0klqQtGTMhPzVvOqMqvdexEVkZpLD6ssXqQX8=";

  cargoBuildFlags = [
    "--bin"
    "code"
    "--bin"
    "code-tui"
    "--bin"
    "code-exec"
  ];

  nativeBuildInputs = [
    installShellFiles
    pkg-config
  ];

  buildInputs = [ openssl ];

  preBuild = ''
    # Remove LTO to speed up builds
    substituteInPlace Cargo.toml \
      --replace-fail 'lto = "fat"' 'lto = false'

    # Fix version in Cargo.toml (upstream has 0.0.0)
    substituteInPlace Cargo.toml \
      --replace-fail 'version = "0.0.0"' 'version = "${finalAttrs.version}"'

    # Also check if clap is using env!("CARGO_PKG_VERSION") and needs updating
    for file in src/main.rs src/bin/code-tui.rs src/bin/code-exec.rs; do
      if [ -f "$file" ]; then
        echo "Checking $file for version references..."
        grep -l "version" "$file" || true
      fi
    done
  '';

  doCheck = false;

  postInstall = lib.optionalString installShellCompletions ''
    installShellCompletion --cmd code \
      --bash <($out/bin/code completions bash) \
      --fish <($out/bin/code completions fish) \
      --zsh <($out/bin/code completions zsh)

    installShellCompletion --cmd code-tui \
      --bash <($out/bin/code-tui completions bash) \
      --fish <($out/bin/code-tui completions fish) \
      --zsh <($out/bin/code-tui completions zsh)
  '';

  passthru = {
    updateScript = "versions-nix --update";
  };

  meta = {
    description = "CLI to build agents that write production-level code";
    homepage = "https://github.com/just-every/code";
    license = [ lib.licenses.unfree ];
    maintainers = with lib.maintainers; [ zimbatm ];
    mainProgram = "code";
  };
})