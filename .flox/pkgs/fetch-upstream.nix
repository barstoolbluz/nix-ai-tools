# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "2296793afdc076c2fd495ac21b914c26a9f2bf0e";
  hash = "sha256-MeaRZmdyd9FaM1BY+GIp/OkhYdqqYd03kIAmoNWlz0E=";
}
