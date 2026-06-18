# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "cf6642d1330d158ceee9d4770e085ce86180a0e0";
  hash = "sha256-PESLN9z2WfRSFDWR6ZAeYU4l/Xq7oqqLn7/Myfk1OhE=";
}
