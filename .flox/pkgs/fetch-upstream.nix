# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "ee05b5abb7c7f4af84a5ad5420f8a6e662774f2b";
  hash = "sha256-8HlfWrlXejz26+kK2XQuNvhO6wpQ3g+JOONywNf8d1E=";
}
