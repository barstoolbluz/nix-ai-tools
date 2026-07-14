# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "9e2dbe1e09a619318696da505dd183c4d36f3048";
  hash = "sha256-FZa9vA21dkvLerk20uOt5Gn87VND4GBwXoPBk8JSobw=";
}
