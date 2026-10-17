# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "ef3189d3d36be9dd77426f2acfc06c7a18b7cf17";
  hash = "sha256-ArQPrH+4UinKlwYOq6YG4LNwOgg8IqlBwDaOhwiFWiQ=";
}
