# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "6b4673fddbbe1f2656b3fa8d2a32666570aafbfa";
  hash = "sha256-tBvsFPJy0/2gocc6QGYFXJF44TvJ8PC726NsdTpFJ44=";
}
