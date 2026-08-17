# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "6c900e65b99ccc11f4a993ad3f02cf4bf548b03c";
  hash = "sha256-qjrMmBum5q8uA1ntcCnuRBIaqHpM/MjqfXhPdW5pNFA=";
}
