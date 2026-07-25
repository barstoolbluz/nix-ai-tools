# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "6216e675a74669975cb4b6e3cf0f7008e5154618";
  hash = "sha256-FZ6ytkLifLRhVJWvTcbYljiLjAI1mGAn3Bkt09INIek=";
}
