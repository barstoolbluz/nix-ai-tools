# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "66da7e555dd72e9febcf48590bd7d6e7df89e421";
  hash = "sha256-rTFzO2mwfButzMsnwJkHnXBfjfeZyxiZ24ZtoCdrWUU=";
}
