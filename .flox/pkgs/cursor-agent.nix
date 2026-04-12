{ callPackage, fetchFromGitHub }:
let
  upstream = import ./fetch-upstream.nix { inherit fetchFromGitHub; };
  helpers = callPackage ./fetch-upstream-helpers.nix { };
in
callPackage "${upstream}/packages/cursor-agent/package.nix" {
  inherit (helpers) wrapBuddy versionCheckHomeHook;
}
