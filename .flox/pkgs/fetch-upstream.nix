# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "83984ebbbe5322b261d9fdc24eb15cf44f23abec";
  hash = "sha256-pwJhtpRcNX1pJ9luUy3Eh1EYUFsZjv5m2xSqZ1hEhMU=";
}
