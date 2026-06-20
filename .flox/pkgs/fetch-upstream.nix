# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "6d65e7002dd5fe407af6d989ea49f9e89619d4db";
  hash = "sha256-VbghtmBX09cL/JIm5fXSzHnI2tFE8lorxe9Fx/hE6yk=";
}
