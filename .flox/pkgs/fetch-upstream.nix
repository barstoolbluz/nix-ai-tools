# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "a418d272c8ed1f30bce9919cd738d347bf2d9d1c";
  hash = "sha256-0GsJQ21NfXn9A3RUfXt0XurhDhMu8hfGCFyv+dNlbqo=";
}
