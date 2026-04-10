# Shared helper to fetch upstream nix-ai-tools repository
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "nix-ai-tools";
  rev = "bc514c88404cbaa8467046aabf751fa781a8652f";
  hash = "sha256-XnJYW5CuYPVXXVTJF+00ggJLiAwMSZSxZ2Q1oAFF7xo=";
}
