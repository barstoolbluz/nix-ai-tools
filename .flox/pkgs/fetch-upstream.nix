# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "c2351168cdce1d7ab47961266b999a449f23bfad";
  hash = "sha256-qYKCHhnLrEQ5XOH/5vwc57FSpPNCWC/4+AcWjJa7vPE=";
}
