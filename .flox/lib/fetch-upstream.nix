# Shared helper to fetch upstream nix-ai-tools repository
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "nix-ai-tools";
  rev = "a5eb2131473bdaaa6081db3d17eb1b2a98b5e781";
  hash = "sha256-1jjzlxnzrhvvbxzy9i9fhm3jiclkrd306afp5qjrx3pbf4v1a2b4";
}
