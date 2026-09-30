# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "af40d966859ec4075ecc172dbb39e53f474dc5d9";
  hash = "sha256-I4O5GSbZgmvzV7dj8fZN8furV2UdEpahh4rvsZOfs/Q=";
}
