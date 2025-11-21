{ callPackage }:
let
  # Reference the local package from the repository root
  # Using builtins.path to include the local source
  root = builtins.path {
    path = ../..;
    name = "nix-ai-tools-source";
  };
in
callPackage "${root}/packages/opencode/package.nix" { }
