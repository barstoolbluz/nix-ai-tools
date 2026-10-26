# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "a5500f41321b0a6b68407500f26dd55dbeb5793f";
  hash = "sha256-t//ltF7M58hc9Rqags5IQCLyzMOPgAuyxkzDwcn1bj0=";
}
