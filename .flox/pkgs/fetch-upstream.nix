# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "c063ac9d0996bacacd6d79c0088c513002846ff4";
  hash = "sha256-lDqdFwabA2Z2hlN7QoScaK1iAVYZCkSHqvSDRL714TM=";
}
