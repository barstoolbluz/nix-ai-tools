# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "35d6c8743b6406d7e8db0226dd694313912b528e";
  hash = "sha256-mac4COq3+ooQHB8qeaJ15DpLMdrAdS85YNjmqdl21Qs=";
}
