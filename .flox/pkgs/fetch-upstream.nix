# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "3a78485c5ec8c10ec53915410c724a4492cea4bb";
  hash = "sha256-Ho5xXKbluCp1lmvUkVwrN76fUW1NC3RARdNaFMGpEcY=";
}
