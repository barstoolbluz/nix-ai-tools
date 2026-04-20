# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "37b4c128405f91c43e8be96b5760140a03b71fd0";
  hash = "sha256-8qPKHx9VVTY2aHYkUWyRxO/l4YJurFa2U2/iYU7D9/A=";
}
