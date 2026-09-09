# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "4a6df59bfd94e0a0059455a15d0d1df8b7c7610c";
  hash = "sha256-xo0f0bAiTuMpm7ISCRoJGnqljcKXHBYdy9U4WgHmbGc=";
}
