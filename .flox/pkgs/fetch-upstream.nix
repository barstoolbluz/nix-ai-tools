# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "84a9f135716cbcdc1fa58ab3c52b85f9a1a0cd0f";
  hash = "sha256-jXmORmL8tbeyDo7/FiPk68P+UBctz/vph2x8XMHg1uM=";
}
