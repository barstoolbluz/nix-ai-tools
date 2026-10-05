# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "ba24820b562c0e1ff95d283a2e2e1debcbcbad83";
  hash = "sha256-1szYaEAFYPApOgy2HGLbqtVys8SIqk5mlvz9agPFLr0=";
}
