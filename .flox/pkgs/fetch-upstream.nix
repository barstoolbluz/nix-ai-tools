# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "c04a0c706b61be541e324a9db9f98e1536d81862";
  hash = "sha256-pMcR4/Nyi03ta+twhDZEm/zN6rhMWyozDcjJsInk1sQ=";
}
