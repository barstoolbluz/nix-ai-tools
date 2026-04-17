# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "f18497e5b190912fc7bfad822d3f6b7f02c43444";
  hash = "sha256-/u2hD8oduiJheEBw00CaogcGtY1J9Ej8GhyLqACFsSM=";
}
