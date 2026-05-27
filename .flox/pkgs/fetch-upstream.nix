# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "93c592a1bf2bfcb7e72b9a5344611efcf72917db";
  hash = "sha256-TK1oFHU2SPXuB1gUX3SnqNujViWiYIPYTuWxXy1wR6U=";
}
