# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "164e1ac949fb9e19061f10768165447227c1d04a";
  hash = "sha256-vmznH4psx74Uh/RxMn+4FRU6Od/6zypoUTq7h9ZsUgo=";
}
