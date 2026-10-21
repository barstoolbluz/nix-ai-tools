# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "67094fffbbcee1816ceff9abf2270865a4d9acba";
  hash = "sha256-IKwTRR/NGqwIilc9E+xePm590U5CdaXU0IbHX9dvmag=";
}
