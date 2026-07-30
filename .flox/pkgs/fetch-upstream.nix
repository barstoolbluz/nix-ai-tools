# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "e23b9c324dd5a79189d97e5603067517ac629c0d";
  hash = "sha256-U7x7jYEBE3kFpmZI3CGP7fLC/uz/KxS3uTtg36AoEok=";
}
