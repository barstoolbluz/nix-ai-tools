# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "b7e045a19cdbc9d5c093e90fb916e69c8405ba8a";
  hash = "sha256-HmEzmCBUE7tZ0jDSep4JGCfmBq9P7uw8yB9egg7wWT4=";
}
