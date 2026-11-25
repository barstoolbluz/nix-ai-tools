# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "d70dfebdbd4616aa852fdb47c16588ec1ba8fc6f";
  hash = "sha256-HUVg1F7c3btLD++JDjdTsSAwp50NvrciqTMFdCKEfAg=";
}
