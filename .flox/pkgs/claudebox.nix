{ pkgs, callPackage, fetchFromGitHub }:
let
  # For claudebox, we need to use the old upstream that has it
  # Current upstream removed claudebox
  oldUpstream = fetchFromGitHub {
    owner = "numtide";
    repo = "nix-ai-tools";
    rev = "9947f0f8bd78775953478b6272180c5df5364acf";
    hash = "sha256-YkDfnuIfOig6eSIA59BaQ8Xl/FEMkOBLBGhw2Z9ihlA=";
  };
in
# Wrap the upstream claudebox with version info
let
  claudeboxBase = callPackage "${oldUpstream}/packages/claudebox/default.nix" {
    perSystem = {
      config = {};
      self' = {};
    };
  };
in
if builtins.isAttrs claudeboxBase then
  claudeboxBase // {
    version = "0.1.0";
    meta = claudeboxBase.meta // {
      # Ensure version shows up
      version = "0.1.0";
    };
  }
else
  claudeboxBase