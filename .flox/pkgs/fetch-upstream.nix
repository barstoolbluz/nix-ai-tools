# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "91ff550fe42d4dd51dcf8b6bad87a0134fe7f314";
  hash = "sha256-JxeqQKUhBn5kj6xfE4nIrxw/q3jFJyT+TKc8mLsnuhc=";
}
