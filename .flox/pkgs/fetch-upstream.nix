# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "db3d0ee0d80bb3ee7bc6e5c6d802ea52840e42aa";
  hash = "sha256-vNNap+guGjdP2Y9lDAKXXwNipGu6XZRafUL29SYXg94=";
}
