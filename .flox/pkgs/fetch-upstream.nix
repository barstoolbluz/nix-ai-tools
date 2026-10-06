# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "6e0c55a8d702a9f49d4a8c99df0749cf9b96d34d";
  hash = "sha256-dVcn8R4EhA6BF7+bKIKI8vMELjk/khHIFo3jmbG64FI=";
}
