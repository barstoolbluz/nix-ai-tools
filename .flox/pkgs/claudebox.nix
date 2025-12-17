{ pkgs, callPackage, fetchFromGitHub }:
let
  # Get the current upstream (now llm-agents.nix)
  upstream = import ./fetch-upstream.nix { inherit fetchFromGitHub; };

  # claudebox is in the current upstream at packages/claudebox/default.nix
  claudebox = callPackage "${upstream}/packages/claudebox/default.nix" {
    perSystem = {
      self = {
        # claude-code is also in the same upstream
        claude-code = callPackage "${upstream}/packages/claude-code/package.nix" { };
      };
    };
  };
in
# The upstream uses runCommand which doesn't have version
# So we'll just return it as-is since runCommand packages don't support version
claudebox