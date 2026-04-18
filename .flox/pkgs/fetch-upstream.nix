# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "a350931b10f337e1d6c32a814c410feb3d4fa97a";
  hash = "sha256-YBkhD3aKU/5q0G4xABRaPLsg49o8hjgYvEFyZrOr6a4=";
}
