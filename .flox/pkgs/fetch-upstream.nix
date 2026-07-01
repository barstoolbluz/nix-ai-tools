# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "2a0d5e87e34cbec74c2df9764eeddf1a655d2046";
  hash = "sha256-bmM+TfnodBmk/95HE/eIoNzRY8b7wRWbcYU3cUvKIZw=";
}
