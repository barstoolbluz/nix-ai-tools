# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "45e6e554481f962d4134021d3a63c96d8755f395";
  hash = "sha256-hhROWq9062PdIznKMqiQuy3L9F7l4LHwofEVrcncfZM=";
}
