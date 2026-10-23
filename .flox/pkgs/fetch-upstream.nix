# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "4726c319ae0692a84f20819395411d9f8b88335a";
  hash = "sha256-91rRFnBm9hpMIAFYi+ZvuLOupMtBMrnMVsd6CmH5ik8=";
}
