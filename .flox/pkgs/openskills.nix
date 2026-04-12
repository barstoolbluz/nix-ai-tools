{ callPackage, fetchFromGitHub }:
let
  upstream = import ./fetch-upstream.nix { inherit fetchFromGitHub; };
  helpers = callPackage ./fetch-upstream-helpers.nix { };
in
callPackage "${upstream}/packages/openskills/package.nix" {
  inherit (helpers) fetchNpmDepsWithPackuments npmConfigHook;

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
