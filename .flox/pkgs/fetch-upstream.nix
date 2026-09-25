# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "1446b3cb242c8cd24619b58054112cc2d870e591";
  hash = "sha256-bOexMr1RcAS6PFcMnEfwe5apsEoaLmSUUxlqUftd2uU=";
}
