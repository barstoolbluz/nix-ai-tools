# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "bbb0f9a24c3a5ce918f3d8103397ce08b20300e1";
  hash = "sha256-vD/DZ9vxJWz4iorDqMYhYdx38ZbuhsFAWuhZoYBM7Uw=";
}
