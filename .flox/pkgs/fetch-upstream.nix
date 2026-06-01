# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "0e4618ed6c946427e3d036925f98211220834892";
  hash = "sha256-OdVUSGJCuIi33eWsIT0Cmvw3HvfsSslwuKTBUrY1zcc=";
}
