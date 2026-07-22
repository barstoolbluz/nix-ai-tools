# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "4c7c70e041d43f04633d95fae6cc52ffacf8f615";
  hash = "sha256-cyosX8nMREmlC0m1RCbWm1fv+ekYHLY+fvEJn6gTTJk=";
}
