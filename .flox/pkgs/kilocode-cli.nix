{ callPackage, fetchFromGitHub }:
let
  upstream = import ./fetch-upstream.nix { inherit fetchFromGitHub; };
  helpers = callPackage ./fetch-upstream-helpers.nix { };
in
callPackage "${upstream}/packages/kilocode-cli/package.nix" {
  inherit (helpers) wrapBuddy versionCheckHomeHook;
}
