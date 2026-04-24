# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "645fe817aaa212d8a6981abf2d996f69a7e78fe1";
  hash = "sha256-snu8Xa+VKZLF5nPinJvHllM4QZ14I/+1890qZFp/RnM=";
}
