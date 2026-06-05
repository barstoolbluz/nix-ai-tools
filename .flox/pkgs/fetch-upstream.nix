# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "f764eba1fdd162a1f2bc923f7e7034b894a22b4a";
  hash = "sha256-dgnL2gTgRoO1D4z6wkARGCO/gimq3/UE/mVFcQcWBn8=";
}
