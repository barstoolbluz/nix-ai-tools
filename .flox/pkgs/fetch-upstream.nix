# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "efb10f28f7242f0330eb06436a672473dc91a2a9";
  hash = "sha256-bAidl4dz4pDwyposk362MTqdiGvtASnYaLRW4yqSYd0=";
}
