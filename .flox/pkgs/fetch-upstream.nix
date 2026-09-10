# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "e320800dd9dc2b156bfa77fbeeb00e9e7295f3a9";
  hash = "sha256-ykJRnaTqcTxPrUTdhVwpd3nLT3p+PvitmhbxZbgo5HI=";
}
