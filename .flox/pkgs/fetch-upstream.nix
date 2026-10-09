# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "4bb57cff45b5554a02dba0cf7a8c7f4f010a864d";
  hash = "sha256-Q6VbwYvayJgN/7x4jI7KnSkd5NGyUwfUw57Dho4jJAE=";
}
