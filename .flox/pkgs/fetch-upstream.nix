# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "304ada966596829e870cacc580e6b8bf27186744";
  hash = "sha256-0o/VXqH7ENNuDZ9YOL2JMUo0wkhZc6FUKLUwGOwGq1A=";
}
