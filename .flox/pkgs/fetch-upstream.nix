# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "5f9d86061f538b3f5f3568583c001fb9c0705b71";
  hash = "sha256-hcxEl/eWQQaYkUqygP4ca8S7WlX9c6vqgvQCqtV3vuw=";
}
