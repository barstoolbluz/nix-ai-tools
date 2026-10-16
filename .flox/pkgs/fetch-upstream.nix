# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "64f24d6169b8e5996e0c3a3ae696bdf11806b34e";
  hash = "sha256-Nfg3uuj6SrYd95vB2acYHLvQfjs9L2WZwMgkaKsQyOs=";
}
