# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "ccd30237f9cf64835a536a20a3546b1112934a62";
  hash = "sha256-b0K1GfAO/0ZHarb8bKU7xCo+qV8Q1NBT/eB9I8RoWoI=";
}
