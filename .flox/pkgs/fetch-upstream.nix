# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "259355b27d1a3a618a7f1f4af5befb990335b00c";
  hash = "sha256-GFFYlUoiaXZLCXh3TIdVcEid9Q1p1NJ3MozOD+kZioY=";
}
