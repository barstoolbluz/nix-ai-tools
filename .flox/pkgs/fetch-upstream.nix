# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "f185c64c76f04b57f0a8a4ff7cbd4028181245bf";
  hash = "sha256-0U1FIUfSKzVnsEm+lIOxS4IIA+YodkmlLBE7zkv12zo=";
}
