# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "372f0337e8170e55ff0c017cd43ab73b02a062ad";
  hash = "sha256-0MHqf09PIjbpfg7KhUN/r1vGJ9OS5A2TSMq99n+Y7XU=";
}
