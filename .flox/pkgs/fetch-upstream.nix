# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "117d535651dbc455ad92f37fc5b36e322bfddbb7";
  hash = "sha256-VYLmeUWE2Lugk/9sgfPDKFQMJUR2kjvm+oeB1I66WtU=";
}
