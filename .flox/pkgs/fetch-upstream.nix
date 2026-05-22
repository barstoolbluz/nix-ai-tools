# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "20e430bd6bc68a3e76f16a31a19504971b1832bd";
  hash = "sha256-n+TRxgTBGwOSqmPGhh9gqtFd9oIHadiQI7KUhpKLd04=";
}
