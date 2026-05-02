# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "a2cd1d9eda4a84d713153f718c8583e1a4c89983";
  hash = "sha256-AmiRSWOXXJyB/rBRZZKwJWRfM5O+xGO4Pe8V+XFd6Kc=";
}
