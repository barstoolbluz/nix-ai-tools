# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "a621acfa43a25731694a8ef64fcbd5a00241e085";
  hash = "sha256-eAXfN6HiUUMTY5Le1PvnxZlGpxMO4RgTDPkr7xzPo4A=";
}
