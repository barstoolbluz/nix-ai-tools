{ callPackage, fetchFromGitHub, lib }:
let
  upstream = import ../lib/fetch-upstream.nix { inherit fetchFromGitHub; };
  pkg = callPackage "${upstream}/packages/eca/package.nix" { };
in
pkg.overrideAttrs (oldAttrs: {
  meta = oldAttrs.meta // {
    maintainers = [ ]; # Remove invalid maintainer reference for Flox
  };
})
