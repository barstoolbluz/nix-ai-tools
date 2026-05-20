# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "3c69691d60d50f87cc0d5f6222992b63c90b010d";
  hash = "sha256-pXnXgFvoFQKt4gDnOx0OjKSsv0T51QmN5thbzWf9WX0=";
}
