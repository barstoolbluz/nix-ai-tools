# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "04df876de28f0684a0d7110444d7f64da5c14d17";
  hash = "sha256-4IdvJPuLzmpLwBk2iQ1QjKHGi5pt8cvaE5hmkBnr3Xc=";
}
