# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "a0a3dd237787079d714b97ded8c91045dfa71b4e";
  hash = "sha256-pb4mLFS4SXGaRY7/ThcFINGC9oMTFwPcvVpOhw2zPGw=";
}
