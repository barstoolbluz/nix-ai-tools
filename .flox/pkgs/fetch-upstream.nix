# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "50e05f7a7cc039d39d53bc77c132d9457f990375";
  hash = "sha256-8IqYrCfNgO+T4Sc2gM4AHSuqhSgwcrAq0uOTMq9ixKg=";
}
