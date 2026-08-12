# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "8651bf95690800f5361d53a9abda0fc3fbe0e2ec";
  hash = "sha256-whEQ6o21DtquR08u+yuLdHXX8dgjlyNJIyMWcVk+PFU=";
}
