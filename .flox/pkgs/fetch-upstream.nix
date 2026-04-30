# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "de2a3af876b071dfc43afa14976edfc89fd585b4";
  hash = "sha256-xoe/d6DI99r3MWlbS1+3A82NnD6uMpdgEQNqn7cp7Y0=";
}
