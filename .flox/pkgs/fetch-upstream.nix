# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "31405cadaf364d17d2d736e9002efb91558bf07d";
  hash = "sha256-Fxltsmg9SHOTRJuc4x8J/MB6/cEIjKcMGN/9GyKYQcY=";
}
