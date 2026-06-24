# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "3c9586476ad8afad108db3b6586384685ce85747";
  hash = "sha256-VjXPtEjoUNoBWXHmsC+TarsozLXqgbIvAFBYq09Pqmk=";
}
