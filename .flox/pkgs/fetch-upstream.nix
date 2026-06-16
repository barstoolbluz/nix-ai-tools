# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "53673313e86582f3ac7050ff826158fd843c219d";
  hash = "sha256-8ndljm4ics0tWVy/K9zolJiGD2LAVp9RtYnIpIpgp+o=";
}
