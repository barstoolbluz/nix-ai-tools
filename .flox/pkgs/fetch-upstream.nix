# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "33656317a15ef8171dc2efbbdefd5f7b092b57b9";
  hash = "sha256-UG8v0D6MCJs7TCpdpAOLKus+IHktnt4MlV19kFLZQ2w=";
}
