# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "b096325ad8cc471f5b34321c01a5cb98457c7782";
  hash = "sha256-t16G5E/dXM2vHehL0hxiUI+/Sg2l9dOBY948AK8bXOk=";
}
