# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "3cdd27ba85ad0e07a2a39fff42418589d4e0a053";
  hash = "sha256-6UX/fBiS8l/I0SVXeZYCNTk+2RB8yQej6hoLDOE8YBw=";
}
