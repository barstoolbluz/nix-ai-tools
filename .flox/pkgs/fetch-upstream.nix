# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "92de4ace99ea70a24146f7c2b71ff65e4ce358a8";
  hash = "sha256-R1A1JkAHF59JeBqVCHYoV7IJEx6MsBV41cH4jZhuNHo=";
}
