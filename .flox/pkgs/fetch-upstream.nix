# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "43a729a5df4827fd76c8c65795ee07bcd7c5a015";
  hash = "sha256-pLA0eFk5bQtU7C+PtenLwfULE53KPFofCacI1t+YNiM=";
}
