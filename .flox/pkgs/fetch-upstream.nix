# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "9934bc184f4f1e2ad253e64e6739016aa4dead07";
  hash = "sha256-IZOPKCAPqp4C6U1qQNdOlilP3wl7PD3T81/j8ygziH0=";
}
