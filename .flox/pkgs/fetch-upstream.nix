# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "e28ea84e78517e5d05ae0c399da00e848e207261";
  hash = "sha256-+o/d1qwS8bHNwuiDevl+EKYGJ0IjdzroMxpmoY0JmRg=";
}
