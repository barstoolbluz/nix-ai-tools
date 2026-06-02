# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "a531ef0f9dcbaed0f8026a9f82c32281c4a6dad2";
  hash = "sha256-n58coAnv42rXda/GvoZh1D3TmfXikx9I8t3/msIXFn4=";
}
