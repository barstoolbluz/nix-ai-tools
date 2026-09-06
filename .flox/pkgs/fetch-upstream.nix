# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "e44191f87d0fd1990a7b38fb0b89af1af8d541d5";
  hash = "sha256-VAgCiLV/S2R525JvI6a5jt5whLzKMbzzbEJnHaPtTYI=";
}
