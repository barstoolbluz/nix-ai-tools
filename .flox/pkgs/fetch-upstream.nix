# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "fcd7079ff30bc4774cc2db48bcc568a42098e9b0";
  hash = "sha256-us2LMEII2b+B6ZRfsryZr3fsYOEL077ZYdtJYLFgbRo=";
}
