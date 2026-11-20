# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "fb6d019e1079a14197823e442c47e45b3ad3d6ed";
  hash = "sha256-aUsA49ny27NyzZn/Gc74hiT/06iazG1IZe9FihxmYZM=";
}
