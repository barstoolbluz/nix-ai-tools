# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "a8e2ca87ef6a622821d175555d320e196cac2d34";
  hash = "sha256-j1S8p6N1lAu0Ab4csCu3JmSDS1xzPc5nlUqFUcjMNBg=";
}
