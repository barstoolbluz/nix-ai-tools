{
  lib,
  fetchFromGitHub,
  rustPlatform,
  pkg-config,
  openssl,
}:
rustPlatform.buildRustPackage {
  pname = "claw-code";
  version = "0.1.0-unstable-2026-04-09";

  src = fetchFromGitHub {
    owner = "instructkr";
    repo = "claw-code";
    rev = "6af0189906939aa053ade9599bdb2b5182ae1fe2";
    hash = "sha256-2A+M7MVUYjLoIZpIO7fLQ9/RHp9Gpb+RS6A/xDXDn9Y=";
  };

  sourceRoot = "source/rust";

  cargoHash = "sha256-P8QqUM1s/fNv7Fb4dmpJWDfTNumgUu1Cdiln8ybSDUU=";

  cargoBuildFlags = [ "--package" "rusty-claude-cli" ];

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [ openssl ];

  doCheck = false;

  meta = {
    description = "Claw Code - A Rust-based CLI for Claude AI with tool execution and session persistence";
    homepage = "https://github.com/instructkr/claw-code";
    license = lib.licenses.mit;
    mainProgram = "claw";
  };
}
