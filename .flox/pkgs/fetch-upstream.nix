# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "40c1d8a8e37ee71560953cd269fb52cc2ba9d464";
  hash = "sha256-skbXCzMgZVerToN3LWaE1V9anxpVWn+RZqRUzpT9io0=";
}
