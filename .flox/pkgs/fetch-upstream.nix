# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "dbd0928ca24380fe62f485785f5fa097f45f4b50";
  hash = "sha256-XdUwPMY4dmsYJrwdSqSHDV01mSJRqwXHSdTRCEDeecs=";
}
