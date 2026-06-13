# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "24ec6b7b1ddf8896ac8df3b65dc564575e0a1928";
  hash = "sha256-2fFAGel2VVXr5mwrTXldqXva2ng3T3HHxyuBKRIxauI=";
}
