# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "8e1a8e0fde8d660cf18e042d6daf7cea3f8f8e86";
  hash = "sha256-ake1nqFgKstRazw4OwxeOLMjTsN3sF+3IwWs9RrsS3A=";
}
