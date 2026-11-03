# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "5ba207f9d264f531e473a4ea8b3187c9ced912f9";
  hash = "sha256-yCY0C0Ta7jfK0uSssZ3uEOfER9aZuZV0gj9W7bJIK6U=";
}
