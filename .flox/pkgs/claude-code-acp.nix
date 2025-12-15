{ callPackage, fetchFromGitHub }:
let
  upstream = import ./fetch-upstream.nix { inherit fetchFromGitHub; };
in
callPackage "${upstream}/packages/claude-code-acp/package.nix" { }
