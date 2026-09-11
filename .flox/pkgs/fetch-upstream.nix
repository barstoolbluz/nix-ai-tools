# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "3a31e665ca59fc6e553610d96100cc08cbbc759f";
  hash = "sha256-0i3Gd0hjiXLeQGPrpvNx85iynzG/5/Q7523pTdt1kwA=";
}
