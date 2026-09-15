# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "007fe0dc62fe091bbc43f792358746bf69e8d184";
  hash = "sha256-zzKsnmYjlx4evOcC20fMG/l2XlRqfvcFeJZoIa3ELu0=";
}
