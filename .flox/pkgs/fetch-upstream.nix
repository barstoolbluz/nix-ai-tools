# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "7b26ba8d6053ae3275ff18337e4659c72551d86a";
  hash = "sha256-hO3W+i6culQlaePGy/ikPV19ib5PE7LLOWSkBj1p6JY=";
}
