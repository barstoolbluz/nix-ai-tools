# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "3ba11af458c6b66a83447bc6bf6fe180b237d0da";
  hash = "sha256-5KruClwP+Sseafmf4xFksKJA1eYajegMkAbTHIcv2CY=";
}
