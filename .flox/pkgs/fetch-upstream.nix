# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "63eaec5890d3dfab83d7fdee5a2dd2bad06e165b";
  hash = "sha256-rGb5Lywt3gMaWaVBLlWNTgypCWjiekuYG0i39Q6qusY=";
}
