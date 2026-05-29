# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "3d06fc69a2f33f9353504facb481ef2bb8465add";
  hash = "sha256-4cjtg7FkVkg2r0lMsZ7nb9H8F0elNn9UDTMPb9jf0gA=";
}
