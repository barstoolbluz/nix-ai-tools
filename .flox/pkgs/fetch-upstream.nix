# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "9300f2adc8ff27f02c92b48efc5ab76955ba1046";
  hash = "sha256-tyldMcr6qS8XrZdFKc6iqnkLPNxaRujzuJ09jOGES+s=";
}
