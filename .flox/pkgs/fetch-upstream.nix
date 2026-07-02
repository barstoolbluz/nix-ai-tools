# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "ce2287ce07b78f033a4d04e229be34eb2de9cae1";
  hash = "sha256-MGkohe8+gQpDQaZNMrandWvmLXNYuMM62ZLd/jt5Tto=";
}
