{ callPackage, fetchFromGitHub }:
let
  upstream = import ./fetch-upstream.nix { inherit fetchFromGitHub; };
  helpers = callPackage ./fetch-upstream-helpers.nix { };
in
callPackage "${upstream}/packages/claude-code-acp/package.nix" {
  inherit (helpers) fetchNpmDepsWithPackuments npmConfigHook;
}
