{ callPackage }:
# Using local package definition with Cargo.toml patch to fix version display
callPackage ./code-package.nix { }
