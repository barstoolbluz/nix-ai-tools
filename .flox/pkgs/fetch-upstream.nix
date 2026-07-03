# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "089368016171843a289494c80e6f78b2ef5eb1c7";
  hash = "sha256-+O4gQbj9n+f2LDuDlZNrrO5XlEtU6P7xunGFudgYkjc=";
}
