# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "63202324e303149b221ac18a49dfc9b3b9df1cf4";
  hash = "sha256-29ar/qdXgn0koWLZbIFLnfPv8P6z2taBzjFTxaAypiM=";
}
