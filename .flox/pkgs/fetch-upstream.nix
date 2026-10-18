# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "3c5fa1e40a7f8e25761f786b8781944a2ce5724a";
  hash = "sha256-UR86GaPSxyubi0DUy9zdF/JcH8lJb3KOQ715u8dNcGo=";
}
