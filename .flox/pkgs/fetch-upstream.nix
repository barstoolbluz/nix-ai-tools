# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "4ed83c77f882225ad3d16288821312b032a918bc";
  hash = "sha256-nIWkh0QCkcrahD/EjMof039JDgsHnmsGikteabARrr8=";
}
