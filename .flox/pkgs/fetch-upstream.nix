# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "238eb2728ede4b4e5ac3ec276bc81732b8df0b69";
  hash = "sha256-7HsiKhCUxnsldqGQRF8sDV/9t6N15Jb3PBZYR/9RJFA=";
}
