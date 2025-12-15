{ callPackage, fetchFromGitHub }:
let
  upstream = import ./fetch-upstream.nix { inherit fetchFromGitHub; };
in
# Note: This package only supports x86_64-linux due to architecture-specific dependencies
callPackage "${upstream}/packages/backlog-md/package.nix" { }
