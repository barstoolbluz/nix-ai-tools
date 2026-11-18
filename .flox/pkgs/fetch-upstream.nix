# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "6b0412eca7185b505fa46e39831e3858ad94383c";
  hash = "sha256-jVrIpI8+sVyHIcP2UAmJ/gyyNX49Wns/5hiuDJx0btE=";
}
