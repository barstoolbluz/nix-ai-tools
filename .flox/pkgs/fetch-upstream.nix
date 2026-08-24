# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "6c76c7db8b5903c16b5a6cad4ff40b19480485ba";
  hash = "sha256-pBudocRP4VmoaR18qqVzfQL4k4srn69OiDJ27ywVJoI=";
}
