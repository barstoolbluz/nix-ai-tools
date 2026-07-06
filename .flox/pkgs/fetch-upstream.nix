# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "22f1080fb54a217bdda6cfd6eca5dbf9e7afddac";
  hash = "sha256-iiQL/IHgQlmnZgKgs4wBOiDA9+S3tRFsQPRxtYIhUYo=";
}
