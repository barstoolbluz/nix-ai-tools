# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "1a30e47b2e639c3286f6379d2811711ce4906950";
  hash = "sha256-AR6RSK2b8SLGWSDqlni+OnAp8z5NqZo5Lih3+4J4Jdo=";
}
