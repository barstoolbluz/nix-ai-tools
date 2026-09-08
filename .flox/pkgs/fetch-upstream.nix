# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "296b980f3a95823d2b2f9d5822d10eb99ea8443e";
  hash = "sha256-8wZHO3gePzZR4QpORDB4QpD/8jdNAFel7kHixn1A/gc=";
}
