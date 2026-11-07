# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "70f935080caa586fd7d0ae6703b155d487b93af4";
  hash = "sha256-i1OMvN+VWCPM2sP6iMeXjDXpMh/h+OoJK+bO018rjU4=";
}
