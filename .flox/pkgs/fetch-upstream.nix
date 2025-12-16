# Shared helper to fetch upstream nix-ai-tools repository
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "nix-ai-tools";
  rev = "431825d77100f10e23853c0fa3edc357e11f9382";
  hash = "sha256-QX5/kwdAsxgfsbwM68jMEtv4MBZjps9vwXhKRUVQZbc=";
}
