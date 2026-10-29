# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "e452052b9efb54fd59f8a06cbc09978fb542a3c2";
  hash = "sha256-pU0HWLzBuoGIYLMIjoZNqiALCAUl9JwV6ujIyOZO3i4=";
}
