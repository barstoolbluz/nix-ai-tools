# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "ab203e473fe0bd7125bf5f9b5f19290075b2c10d";
  hash = "sha256-51XuZ9Vdd3zmltjvS2GH9CbY1/qu35mSeKFH37Tw23w=";
}
