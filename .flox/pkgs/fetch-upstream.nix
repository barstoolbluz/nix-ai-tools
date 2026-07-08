# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "bd0f91f75a704d13bcae84ee7521e3720edbeb2d";
  hash = "sha256-1RS9ipEDGpEIHmLuPd9e24SkkujSeEzzIK0rzZHCUnw=";
}
