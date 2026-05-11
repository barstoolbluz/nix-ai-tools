# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "dbf3500905ac7ad3b5c7776f924a4ac712dd52c4";
  hash = "sha256-7vtGE8Qhm07GQaQ+S8xmwhyLhwoPU4f5c0zlmEAom3s=";
}
