# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "34749035633898914f8cd18684892e16eb3df9a9";
  hash = "sha256-s42/j7jGM6ZV5z0a1GfEbJNNF0zhy1ZvdX2/HjZ2bAQ=";
}
