# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "fdd62d577cdb5fcef6ba9505833d2a3600a68afd";
  hash = "sha256-1TxMulxgMf8k2m5WRtaO9NLRXclEk8i7O7bEvblZKPg=";
}
