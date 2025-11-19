# Shared helper to fetch upstream nix-ai-tools repository
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "nix-ai-tools";
  rev = "a2dfa932ed37e5b6224b39b4982c85cd8ebcca14";
  hash = "sha256-OXJ5BRJ+YgP3zaUOou+jG2k2kDTjJr1KI8RGiP1oU1c=";
}
