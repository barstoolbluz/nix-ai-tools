# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "b14f9d18b6d127221bd9f63817a40e1cca2b344b";
  hash = "sha256-kl4L50m8mMMyQLjH2d46ljtdzR+9vlgpoDmOrpNV/SU=";
}
