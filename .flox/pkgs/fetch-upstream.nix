# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "0b3a6a2dc43576f223d036ba70a29a2f0de99061";
  hash = "sha256-InNpK3w0V6odvKtC5wCXZZiluiWAD6uLElz3to+sQA0=";
}
