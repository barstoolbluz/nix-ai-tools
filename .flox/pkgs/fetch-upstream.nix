# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "9cf200355ad38c1a5306f5d0a633d70ff42b3836";
  hash = "sha256-N28yYMMtCM/ffi6fYob95P+KbFCyXaiQl8FAsG17vVo=";
}
