# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "07e2fc821a8b217f90f1dbd316d319be0746499c";
  hash = "sha256-pUwbt52S1lMVNYp+ypSu0/+4b50gFEXc09Li4K2sx9k=";
}
