# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "6f4945d637942c06390d0fd765c8981874020157";
  hash = "sha256-x+I/CbXlM6pieeCQV/43l4VYr9tORn2ap0hiHa9JiiY=";
}
