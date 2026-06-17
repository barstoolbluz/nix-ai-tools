# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "6b2e2cb6d784cc919c64f998093ecdb4f2b76152";
  hash = "sha256-Upr1PqedUcpeKtBM9Ssoh3j4Oa2WdYASvucKArMKPFo=";
}
