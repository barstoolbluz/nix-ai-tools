# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "03a2450015a30bab3be98ba90a8e66cd665724dc";
  hash = "sha256-ih1+piERuN4l8/ixqbHiT+AR28YFMLA2MMkJIrtfsRQ=";
}
