# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "32b0d7443782bdeacea2bed59ef66d522b8a2097";
  hash = "sha256-gG794N9c3eyZgIolqXwNuIuSbTNzOlMZ2p5MkXvNdGs=";
}
