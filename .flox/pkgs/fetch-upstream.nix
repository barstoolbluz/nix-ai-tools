# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "d17493b6a6d08cc1846a17175df67cd603c80c7d";
  hash = "sha256-M30foxi+2JXQ8KEIeWIKpB2uVpDYOw0XGI/gOaTb38I=";
}
