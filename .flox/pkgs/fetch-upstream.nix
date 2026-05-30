# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "b8adcd1a8e45e6d84f511c1a3b12998634481204";
  hash = "sha256-EnWR9fQzTfmIkyWD8ynYdAM573x3wzkOzZuMagrEosQ=";
}
