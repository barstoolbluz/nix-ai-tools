# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "c9ef0fb47c91abf5c637218b69a018d3b37bb8d9";
  hash = "sha256-3exhcZ9ebN8cVVP+RJe2omsc0l6Mb6ju/kmqCwJJQpo=";
}
