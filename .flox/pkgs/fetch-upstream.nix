# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "20762f12777a611184868a1a4408bc42a014adf1";
  hash = "sha256-F3py52yPDHBSKKkx4CzpTMc5KxzCBT+jLUIRNOYpr4Q=";
}
