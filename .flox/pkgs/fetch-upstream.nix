# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "10a7a6c07357af3351455eb4b3638418a4e76fec";
  hash = "sha256-kbVCdRcll+JaelSqVNHhW38oQD5dctDLi/vRWT9t6/M=";
}
