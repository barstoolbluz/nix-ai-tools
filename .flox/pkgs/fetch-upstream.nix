# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "070d365dd4e883a86cfef891a0f912dcb4245bb3";
  hash = "sha256-Q07oXDA9ngxcMrNjVqEN2pJ8+iADrxEqnFCKUtQFkjU=";
}
