# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "f99bb437fd6860f23ea6c67a5161578a3b89d856";
  hash = "sha256-L70szvZ7LrAX46BY43HHd0bf8rJgtXddsdQV/a/kfQg=";
}
