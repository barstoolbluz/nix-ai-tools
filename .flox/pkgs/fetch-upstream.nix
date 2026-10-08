# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "2109db8971dc18137ff1ac9393627c761609600d";
  hash = "sha256-nRO1wEJmb4wjz+0Mhpg5VWURTqZRBZq3MvMjtPkKuAI=";
}
