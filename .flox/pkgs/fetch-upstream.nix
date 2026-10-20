# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "c31c0e89374ffb6bfffbea37024ba5796d311170";
  hash = "sha256-5TvFiL9BG+eSLqBoy2PwaFnUBkLYuBrFOFxPkWAprDs=";
}
