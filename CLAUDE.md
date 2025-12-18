# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Flox-based repository that packages various AI coding agents and tools. It leverages upstream work from numtide's repository while maintaining custom packages where needed. The repository uses a three-branch strategy for version management and includes vendored toolchains when required.

## Common Development Commands

### Building and Testing
```bash
# Build a package with Flox
flox build crush
flox build opencode

# Publish to your catalog
flox publish crush
flox publish -o myorg opencode

# Switch branches for different versions
git checkout main     # Stable versions
git checkout nightly  # Latest versions
git checkout historical  # Older compatible versions

# Test built executables
./result-crush/bin/crush --version
./result-opencode/bin/opencode --version
```

## Architecture and Key Patterns

### Package Structure
Packages are located in `.flox/pkgs/` and follow these patterns:
- Most delegate to upstream numtide repository
- Custom derivations for packages needing modifications (e.g., `opencode.nix`, `goose-cli.nix`, `crush.nix`)
- Vendored toolchains when needed (e.g., custom Go versions in nightly for packages requiring newer than nixpkgs)

### Package Types and Build Patterns
The repository handles three main package types:
1. **Source packages**: Built from source using language-specific builders (`buildNpmPackage`, `rustPlatform.buildRustPackage`, etc.)
2. **Binary packages**: Pre-built binaries with `autoPatchelfHook` for Linux dynamic library handling
3. **Bytecode packages**: Interpreted/VM-based packages

### Branch Strategy
- **main**: Stable versions using standard toolchains from nixpkgs
- **nightly**: Latest upstream versions, may include vendored toolchains for bleeding-edge requirements
- **historical**: Previous stable versions maintained for compatibility

The vendoring strategy is used when packages require toolchain versions not yet available in nixpkgs (e.g., Go versions for crush after certain releases).

## Package Development Guidelines

### Adding a New Package
1. Create `.flox/pkgs/<tool-name>.nix` with the derivation
2. For packages delegating to upstream, use the fetch-upstream pattern
3. For custom packages, implement the full derivation
4. Test with `flox build <tool-name>`
5. Consider branch placement based on toolchain requirements

### Updating Packages
- Check upstream repository for new releases
- Update version and hash fields in the derivation
- Test build with `flox build <package>`
- Consider which branch is appropriate for the update

### Common Patterns for Specific Languages
- **NPM packages**: Use `buildNpmPackage`, include `package-lock.json`, specify nodejs attribute
- **Rust packages**: Use `rustPlatform.buildRustPackage`, handle cargo vendor issues
- **Binary packages**: Use `autoPatchelfHook` on Linux, set `dontUnpack = true` for single executables

## Troubleshooting Tips

### Build Failures
- Missing libraries: Add to `buildInputs` or `nativeBuildInputs`, common ones: `gcc-unwrapped.lib`
- Rust git dependencies: Consider using pre-built binaries if cargo vendoring fails
- NPM packages: Ensure `package-lock.json` is up-to-date and `npmDepsHash` is correct

### Testing Changes
- Test package builds: `flox build <package-name>`
- Test runtime: `./result-<package>/bin/<package> --version`
- Switch branches to test different version strategies
- Verify vendored toolchains work when used

## Commit Message Conventions
- Package updates: `<package>: update to latest`
- New packages: `<package>: init`
- Infrastructure changes: Use appropriate prefix (e.g., `workflows:`, `formatter:`, `flake:`)