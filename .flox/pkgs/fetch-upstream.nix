# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "c8f7c7882804510f2b807021cac0a69c1aeb4829";
  hash = "sha256-cdSr2nIz4I+ysG1gAZxbKQo+f79vCCKfQCdiRYnyPec=";
}
