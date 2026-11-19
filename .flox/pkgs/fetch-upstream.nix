# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "b2700a2b5e7b94649dd960d08ea3b2304d91b2bc";
  hash = "sha256-49gbHL+NhG0ERyskYJX6E854XnsS3EJK7ta5ZCXhmco=";
}
