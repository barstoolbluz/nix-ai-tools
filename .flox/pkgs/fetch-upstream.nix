# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "7a5c1de3d005ba7e5dac042200bf78268084d1f4";
  hash = "sha256-0R4pdMfxkQMNo3DNQsR5jHqbPmMB/felRqPrKDPA8KM=";
}
