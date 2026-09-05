# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "b1c9a31450a814e50cddc3ab683b05c1dff7bb01";
  hash = "sha256-gXT851aC7kpTGzv2Sn+ZGocAfIBNaYh+QWvHJTpkoiw=";
}
