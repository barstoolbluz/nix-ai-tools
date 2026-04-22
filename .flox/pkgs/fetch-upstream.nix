# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "bb6fb1ef73d5a46877a3fc623fedef5cbf3939e3";
  hash = "sha256-Uo1SvxXlqcxbpoew8deTAbBWDlA/LnkiXQ1PIb95fUA=";
}
