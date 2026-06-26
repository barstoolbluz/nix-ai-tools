# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "500f110747b00e88a7679f1e1efb3b14f83fe7b2";
  hash = "sha256-a+efg5x3tX6BFi+E3DFDzpv71mcLJwE3S6Wv7Q/PN4U=";
}
