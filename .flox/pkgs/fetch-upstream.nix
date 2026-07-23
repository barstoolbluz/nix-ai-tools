# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "aa6a2b6010c2a1a2d187d66abf3ce742033db2b0";
  hash = "sha256-n67WhWgCKrFDiW533y8e0FycUyEa9gt2TvvtQd/A69Y=";
}
