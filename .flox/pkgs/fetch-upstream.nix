# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "7aa0fff2d50775e8b79040824385eaf250a250a9";
  hash = "sha256-1GqON+bTWMrA8tTfZ194tk5Fi8R4YWjBUaScB1mTkmA=";
}
