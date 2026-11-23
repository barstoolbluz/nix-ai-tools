# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "5330ee115c06d2b43f49e902130125eab579b22f";
  hash = "sha256-b1GmfrMPoZ2ANkR0we9Q9KQN6n1e+vNyDqt1p4CNEAY=";
}
