# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "6182a0cd6e1ca9fa9de72155dc9bc4335a4f0b8e";
  hash = "sha256-iwRRrAXTwwL63dt634RWz2ou3p8SIqlkFUKJhS9oGbc=";
}
