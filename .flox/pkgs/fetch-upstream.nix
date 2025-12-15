# Shared helper to fetch upstream nix-ai-tools repository
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "nix-ai-tools";
  rev = "9947f0f8bd78775953478b6272180c5df5364acf";
  hash = "sha256-YkDfnuIfOig6eSIA59BaQ8Xl/FEMkOBLBGhw2Z9ihlA=";
}
