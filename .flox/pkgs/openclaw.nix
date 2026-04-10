{ pkgs }:
# nixpkgs marks openclaw as insecure via meta.knownVulnerabilities (the
# assertion fires inside mkDerivation, so callPackage alone can't bypass
# it). Re-import nixpkgs with allowInsecurePredicate, mirroring
# https://github.com/barstoolbluz/openclaw-nix.
(import pkgs.path {
  inherit (pkgs.stdenv.hostPlatform) system;
  config = (pkgs.config or { }) // {
    allowInsecurePredicate = _: true;
  };
}).openclaw
