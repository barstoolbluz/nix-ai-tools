# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "a1e67cc315b6bd924614d4232e09bab54df3ae39";
  hash = "sha256-Ihdla0v+oCO6dNN6iExgdGc9+JmKLmAnbiTneiJgZbE=";
}
