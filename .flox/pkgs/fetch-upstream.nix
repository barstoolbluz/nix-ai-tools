# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "b4d59ea23a029466b3e8314835ac7714296f2595";
  hash = "sha256-INy8z/zDl0EQSaxIV+S4Xkq99NCWaqBKtxHmJoOdfyE=";
}
