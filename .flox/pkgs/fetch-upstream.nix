# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "91f891c781adae47bfa5539d80f8528b82bf31fd";
  hash = "sha256-W4FRQJ/X6amooqaD6DjLtOiUzUIzyBQOBPAijRMCE44=";
}
