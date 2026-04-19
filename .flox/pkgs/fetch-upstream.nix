# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "87f5aaec69428bbdcea71c6365e3f602f2187095";
  hash = "sha256-uSPdXdhDWAlRzdj36aqtnRWgrHhb+XL4o9NMWu6i+Y8=";
}
