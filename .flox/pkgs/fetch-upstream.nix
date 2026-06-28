# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "c0c6463150522cb3a28c936586f2a2bcb5c4a5e0";
  hash = "sha256-rcCq6LTPi0h5m1OqDhfR6tJvlnxYEW6fYCVnN5jGE4Q=";
}
