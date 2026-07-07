# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "e93955c24dff143c67d3a2e771baac1a4118f5a5";
  hash = "sha256-x+xf38Bg14aL+kbcFJAqs1dvuxMifb79axmzl4kEF9g=";
}
