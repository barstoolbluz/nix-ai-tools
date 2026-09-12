# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "39649c2a6903370136aa7b27c3a2355c2b159e2c";
  hash = "sha256-nTwiP83Ac78Iifx+U8rOPM1wRyVzsRvGqFLN8K1yqE8=";
}
