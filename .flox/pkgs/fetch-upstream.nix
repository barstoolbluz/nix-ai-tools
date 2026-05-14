# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "17d632682c765eaddddcf57b309567fbc69ae5ae";
  hash = "sha256-+JIJZstA++SpZerJMeFnUCPAluxh7pB+R+FHgdpqC+M=";
}
