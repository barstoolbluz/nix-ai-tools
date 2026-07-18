# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "a3da1be8b403f7bce07cd94847ef6c3fbcbd9314";
  hash = "sha256-+xUTmlEXoFwJN+llRGS1q45tfjP6gwswL13R1q+bzsY=";
}
