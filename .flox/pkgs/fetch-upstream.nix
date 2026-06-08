# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "6a40b159e43386df7db43ffcb0435e1af25e3d8d";
  hash = "sha256-0VC7EFQNn+W6m8HvywnZ3/j99//VTtaRw+AEj9Y8YgM=";
}
