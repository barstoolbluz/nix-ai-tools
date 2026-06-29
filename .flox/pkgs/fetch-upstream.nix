# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "70e4e3d55e2ffcdfbd9c89241efcb79a84ca6cb1";
  hash = "sha256-3pX8mc2rLL0UMHN1SILROVUxXFmYPvK+xQcHEZgoXwo=";
}
