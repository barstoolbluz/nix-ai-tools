# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "2dcb8105ad34c1072e24addb0a40ae5dd1124178";
  hash = "sha256-OiTy5CmylptT+VrSemH3ZpQyfXi144Byj1qKXKsvujk=";
}
