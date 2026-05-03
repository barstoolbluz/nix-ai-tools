# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "961b1096bc0b2ecc7096e360646cd2f29671c55e";
  hash = "sha256-GGKC1WrEoTafJwIXn+fim6cZ/w1ZWVc+DUYdk2lvPvA=";
}
