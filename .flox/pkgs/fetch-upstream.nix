# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "05f2ea6072427bfd8b334342a0816b96fef27c3b";
  hash = "sha256-xBvJ+sX/7xOoUrjEzglL5B4nH0YgvYTGPIaj9iLeAws=";
}
