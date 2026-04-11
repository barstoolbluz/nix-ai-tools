# Shared helper to fetch upstream nix-ai-tools repository
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "nix-ai-tools";
  rev = "5bb1482b02bf95da39d00b1e9f705d398d38bb05";
  hash = "sha256-HzcEa1AdjLivJq+IgSwB907coJzggGtedxnVxyGy5zg=";
}
