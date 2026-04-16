# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "fcef4891aa8780d9554f501feadc7b785c065621";
  hash = "sha256-8ctPirjZBJfZYKOa6DccxPsi6xrkKBIQc66yS6SIyfM=";
}
