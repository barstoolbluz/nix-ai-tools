# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "3a994324e0a724f3eb043200368f0b60c06862e3";
  hash = "sha256-ho6vTx7+GLxXZNzp9eCq/X+49s16KLO1EEEGYCkMjQ0=";
}
