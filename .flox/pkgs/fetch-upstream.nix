# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "e711100ae4b583e6a3d20243c639f8e86bd75a89";
  hash = "sha256-5araxl7iFLgrVku59qaFgqRPyvUtG3CggRT1U1Sa410=";
}
