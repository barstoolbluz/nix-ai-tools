# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "c4fe91eee512d8278f2593fc8f544829c76c84f8";
  hash = "sha256-MW8q88uv/Z5DF9UyVKQjlUOBmcoh0OyUWl94aSVtvVU=";
}
