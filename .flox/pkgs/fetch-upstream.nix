# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "c69b3057113428150630c05682fa3cfbd312b4d5";
  hash = "sha256-gVS7RTK4lDeHc18V5vhbD6yR+dkj6spiUzlgYS2OP9M=";
}
