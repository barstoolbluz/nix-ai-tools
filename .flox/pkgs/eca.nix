{ callPackage, lib }:
let
  pkg = callPackage ../../packages/eca/package.nix { };
in
pkg.overrideAttrs (oldAttrs: {
  meta = oldAttrs.meta // {
    maintainers = [ ]; # Remove invalid maintainer reference for Flox
  };
})
