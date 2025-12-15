{ callPackage, fetchFromGitHub }:
let
  upstream = import ./fetch-upstream.nix { inherit fetchFromGitHub; };
in
callPackage "${upstream}/packages/nanocoder/package.nix" { }
