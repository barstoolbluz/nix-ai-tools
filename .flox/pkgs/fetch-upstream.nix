# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "2db27e8a8e019ff6b1a2f7bdb4e3e4eb69caec11";
  hash = "sha256-SCjI5+lIQdX6xG2atKgKvpFC3+3iW3Wp2htY2zRzvjY=";
}
