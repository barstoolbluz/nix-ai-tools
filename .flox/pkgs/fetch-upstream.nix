# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "98c6340e2215a248810fcebd1da6ea01cb955a64";
  hash = "sha256-b9CC9Tyc4FVzx9f8+i99lPJLyTsL5hRoxIJeGl40Mrk=";
}
