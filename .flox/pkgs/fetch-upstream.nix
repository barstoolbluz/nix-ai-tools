# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "ac49270ad075183b818bd16b26a0fa44aeebe655";
  hash = "sha256-vkkjpa04+2BcKPyCr9lAF4swwD+b5sYYYwwjtXMQf1w=";
}
