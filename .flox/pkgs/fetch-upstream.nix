# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "ccf868b7a2a8de6713c0a572885657739a448cf0";
  hash = "sha256-dkX4GGtumxtSOcdwTsS6Dy5LyPv9Nx6Ya6yRx1i3y1o=";
}
