# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "0bedd15c76b9422a649b05e44b82666196e5246f";
  hash = "sha256-HRmx7PnoqUNtA06P/FEyygZeUJIzbNUtx4zo9Jiiz9s=";
}
