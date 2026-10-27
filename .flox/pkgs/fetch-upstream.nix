# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "eaf48f8e126668eebc3eb13e43b18368a4330d95";
  hash = "sha256-bfI04e2dsG3H316poDdpTzUS6uFI43aTWNgYYXkn32U=";
}
