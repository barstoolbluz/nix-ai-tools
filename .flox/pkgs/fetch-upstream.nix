# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "4dd1fbeaa112097d896aceafff35a4137ed96346";
  hash = "sha256-8Dq5kO1gWUjpiRp4OmmSxlf1DdnmMiGcw0l3yZ47Qig=";
}
