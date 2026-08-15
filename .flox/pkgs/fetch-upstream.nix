# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "78f862586038789cbe707812183bd220d8a3bf3e";
  hash = "sha256-qklpa2v5F61V3rr/8fx893+pK5KWiAzm/ipREz0DcY0=";
}
