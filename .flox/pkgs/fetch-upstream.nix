# Shared helper to fetch upstream nix-ai-tools repository
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "nix-ai-tools";
  rev = "b91b0e1583091847cf4f8a8fcaad92d66227abfb";
  hash = "sha256-WrZCxhx82aBBQb6CMJwXimgOIcv9Eytl1zFsjfxiWSc=";
}
