# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "a59764a6424689d67c1bd9070fd48afa44a47ee0";
  hash = "sha256-v8/CnsHh4/p58E5d0k208omIYUUu6EruiKRIYYNNuE0=";
}
