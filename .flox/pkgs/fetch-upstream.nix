# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "9c0f302b8c327f109c443f80eab7928fa661c1d6";
  hash = "sha256-dA9DHO5Rz3yWPHHRRVVn2oGBJcaZJ7zDAjmqY1EQDss=";
}
