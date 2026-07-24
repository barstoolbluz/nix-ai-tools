# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "264604cc0580e87d34a10b82334cf52f8139053f";
  hash = "sha256-Hi41+61t2OmiB9MAq1sjeJ+HRw0T/isE3mL0um5Xmvc=";
}
