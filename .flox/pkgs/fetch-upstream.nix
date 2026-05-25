# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "95a4d2db3c5bd592e14ec5e29a03caa8d997c5cd";
  hash = "sha256-tV518Um+BncHA3gv8jNvJs3Z6nz82t+MLntOAq64pbU=";
}
