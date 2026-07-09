# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "a4c847460f0e773d02d0655ce28dc6b532dd65d6";
  hash = "sha256-LyF84yqWppXAAEOAkL325Lt+DrVmkbbeXGzDgX9zMzI=";
}
