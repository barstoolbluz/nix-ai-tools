# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "d0a147485f849ab4f20c1a61a6ea1c312cd0a229";
  hash = "sha256-jIIa+5nPnhny882wYeq8SOa2WRMjhDU0ls6cgyC1D7k=";
}
