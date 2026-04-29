# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "2641c18f5bb9d0b95e81beca1b0415e174d7e650";
  hash = "sha256-1Bs4ZbBayXWicrOrQQn3/BnnqhEy+tQjdFn40wHu1dw=";
}
