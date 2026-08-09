# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "cb71b8d77ad77e45323c2a23d52360a95ffb9a70";
  hash = "sha256-RcuoAzkbpXl7VvZnTYZRtUmr5HeeRGb76AiP3i3jRYk=";
}
