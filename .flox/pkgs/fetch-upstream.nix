# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "2a35d9020b2d32940903d94da1a2b9a9d63daa95";
  hash = "sha256-ydcK/cDEyiHTGiqI8f2RIq4RVvJC5/YmyMj5fsdf3eo=";
}
