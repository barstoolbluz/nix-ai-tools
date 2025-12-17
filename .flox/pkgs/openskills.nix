{ callPackage, fetchFromGitHub }:
let
  upstream = import ./fetch-upstream.nix { inherit fetchFromGitHub; };
in
callPackage "${upstream}/packages/openskills/package.nix" {
  # Provide flake argument with maintainers
  flake = {
    lib.maintainers = {
      ypares = {
        email = "ypares@example.com";
        github = "ypares";
        name = "ypares";
      };
    };
  };
}