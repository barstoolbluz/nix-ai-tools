# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "39d6cb55aec80e6b8ad309b7b620d920fa246c97";
  hash = "sha256-lfixqU8zNRZIfUSCpQMUUcmikPgmPmvpdk8A6er9vfQ=";
}
