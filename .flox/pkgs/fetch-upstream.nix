# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "02eaebc50f55ee11ce9bc938bcbc5962beaf54a6";
  hash = "sha256-AYNYZPqm8XKQSAniBCQcIAqZjkyWABO3qlcdGgs+dJk=";
}
