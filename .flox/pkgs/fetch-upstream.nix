# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "e22caee8b8e21297ac672acf8f4451a34d6bae4c";
  hash = "sha256-xDcbtGGYHIwNkAWJtf9MJ0/+Y/dbx3zfRGjdMDfNBRA=";
}
