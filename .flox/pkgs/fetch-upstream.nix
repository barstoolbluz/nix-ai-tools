# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "493c34b1bed086861b0e968a40d00bd06522f003";
  hash = "sha256-lvEyxEmXv/8gwiWE2+rxTuL59EFq5wwXxX+rtbxjwLo=";
}
