{ callPackage, fetchFromGitHub, lib }:
let
  upstream = import ../lib/fetch-upstream.nix { inherit fetchFromGitHub; };
  pkg = callPackage "${upstream}/packages/backlog-md/package.nix" { };
in
# Override platform restriction - upstream only allows x86_64-linux but it should work elsewhere
pkg.overrideAttrs (oldAttrs: {
  meta = oldAttrs.meta // {
    platforms = lib.platforms.linux;  # Support all Linux platforms, not just x86_64
  };
})
