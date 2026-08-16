# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "a6f2983a0042ebeace55650f741c237d06eacdbb";
  hash = "sha256-aczld6jPXM4RLZGBpouV11xXI7GYLl6MgBObjDy+OJ0=";
}
