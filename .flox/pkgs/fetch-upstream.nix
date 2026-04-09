# Shared helper to fetch upstream nix-ai-tools repository
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "nix-ai-tools";
  rev = "d6bcf9b4afc751a054a639e062497c2936009064";
  hash = "sha256-aQLGBE3rAbHW5foCCNRtAXAggjuFYlH5t7BDOzWEKho=";
}
