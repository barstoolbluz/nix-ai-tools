# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "10e3dca999e12a0d07f1e9e470707f4386dc3178";
  hash = "sha256-AXj37NDrvBUK5bAgqhPRakqcv+7VuwjLAfRksxsmsCg=";
}
