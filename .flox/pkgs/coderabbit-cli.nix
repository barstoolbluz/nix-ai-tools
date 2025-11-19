{ callPackage, fetchFromGitHub }:
let
  upstream = import ../lib/fetch-upstream.nix { inherit fetchFromGitHub; };
in
callPackage "${upstream}/packages/coderabbit-cli/package.nix" { }
