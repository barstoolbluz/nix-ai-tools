# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "10f2be38f8a46fdf7689697270dd14b27f723aae";
  hash = "sha256-nHvr6I1PDcV6EBquDHE47cIPysnCyhPqQr+OAYse+QY=";
}
