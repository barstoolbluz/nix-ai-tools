# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "44e88554de43257ed4f7298d77b2a15458f828e4";
  hash = "sha256-ajmB9EJXjFEYA0XZIx241e3HzHffnd+xwiyeftsKgV8=";
}
