# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "6159b9a1a78a736cea2977543e74787c5c382dfa";
  hash = "sha256-feJrvdnT9SGuhSG7tYWqPf77L3TxmPtk2Xza6HyEIMc=";
}
