# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "f22857db0b1147caae1250c439d1a21a815b4d6f";
  hash = "sha256-QXnVNc4GXjpQl88yo87Mr/nJ0eQGn8GLySCQqudrTEQ=";
}
