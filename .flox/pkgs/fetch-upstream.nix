# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "1a414b0544329423e764639b2cb1fd5515ac37c1";
  hash = "sha256-pXkzFiRitIAyd/P5i0i1gKpUO3EO1reyfonkRNlXyM8=";
}
