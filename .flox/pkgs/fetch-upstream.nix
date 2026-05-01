# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "285bc2776013c9645f0fe08f8904f6dd13a0e606";
  hash = "sha256-xJ+yhTIbx5ZHRTXnM9dNj2Ont7ewqU9SAIbDrd7U8X8=";
}
