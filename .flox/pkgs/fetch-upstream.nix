# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "8efcba308a6b12a92441cb4df624e484bad9e18a";
  hash = "sha256-i4UBJIugcPJxG4xKnlsypbTb8QfPX+kagQYF9oswO/c=";
}
