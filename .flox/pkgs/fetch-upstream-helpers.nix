# Helper shim: provides numtide-local utilities that their package definitions
# expect but nixpkgs doesn't provide.
#
# Background: numtide/llm-agents.nix uses blueprint-based auto-discovery to
# wire up their own helpers (fetchNpmDepsWithPackuments, versionCheckHomeHook,
# wrapBuddy) when callPackage'ing package definitions. When we callPackage
# those same package.nix files from our own context, nixpkgs doesn't have
# those names and evaluation fails. This shim re-exports them so delegating
# wrappers can pass them explicitly.
#
# Usage in a delegating wrapper:
#
#   { callPackage, fetchFromGitHub }:
#   let
#     upstream = import ./fetch-upstream.nix { inherit fetchFromGitHub; };
#     helpers = callPackage ./fetch-upstream-helpers.nix { };
#   in
#   callPackage "${upstream}/packages/<tool>/package.nix" {
#     inherit (helpers) wrapBuddy versionCheckHomeHook;
#   }
#
# When future delegated packages break due to new upstream helpers, add them
# here and update the affected wrappers to pass them.
{
  lib,
  stdenv,
  callPackage,
  fetchFromGitHub,
  rustPlatform,
}:
let
  upstream = import ./fetch-upstream.nix { inherit fetchFromGitHub; };

  # Numtide's custom fetchNpmDeps with npm-workspace support (packument
  # caching). Returns an attrset with fetchNpmDepsWithPackuments, npmConfigHook,
  # and prefetch-npm-deps.
  npmHelpers = callPackage "${upstream}/lib/fetch-npm-deps.nix" { };
in
{
  # npm workspace support (claude-code-acp, openskills)
  inherit (npmHelpers) fetchNpmDepsWithPackuments npmConfigHook;

  # Setup hook that gives a writable $HOME to versionCheckHook-based tests
  # (coderabbit-cli, cursor-agent, kilocode-cli)
  versionCheckHomeHook = callPackage "${upstream}/packages/versionCheckHomeHook/package.nix" { };

  # ELF binary patcher for non-NixOS compatibility. Linux-only; delegated
  # packages guard usage with `lib.optionals stdenv.hostPlatform.isLinux`
  # so passing null on darwin is safe thanks to Nix lazy evaluation.
  wrapBuddy =
    if stdenv.hostPlatform.isLinux then
      callPackage "${upstream}/packages/wrapBuddy/package.nix" { }
    else
      null;

  # Upstream Rust packages (code, codex) expect fetchCargoVendor as a
  # top-level pkg argument, but in our pinned nixpkgs it's only exposed
  # via rustPlatform. Alias it so the delegated package.nix files can
  # consume it without modification.
  fetchCargoVendor = rustPlatform.fetchCargoVendor;
}
