# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "467c27cb367fa1059583bcadf28390611f66550b";
  hash = "sha256-HiJivFTcq8no0L9bac+3MkaPeFy5gP+LLQMZXQNo5O8=";
}
