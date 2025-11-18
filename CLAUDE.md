# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Nix flake repository that packages various AI coding agents and tools for the Nix ecosystem. The repository serves as both a collection of packaged AI tools and an experimental platform for exploring AI/Nix integration patterns like sandboxing and provider abstraction.

## Common Development Commands

### Building and Testing
```bash
# Enter development shell with all required tools
nix develop

# Build a specific package
nix build .#claude-code
nix build .#opencode
nix build .#gemini-cli

# Run a tool without installing
nix run .#claude-code -- --help
nix run .#opencode -- --help

# Run all repository checks (builds all packages and runs linters)
nix flake check

# Format all code (MUST run before committing)
nix fmt
```

### Package Management
```bash
# Regenerate package documentation in README
./scripts/generate-package-docs.sh

# Update a specific package (if it has an update script)
./packages/<package-name>/update.sh

# List all available packages
nix flake show
```

## Architecture and Key Patterns

### Package Structure
Each package follows a consistent structure under `packages/<tool-name>/`:
- `package.nix`: The actual Nix derivation defining the package
- `default.nix`: Simple wrapper that calls the package (always `{ pkgs }: pkgs.callPackage ./package.nix { }`)
- `update.sh`: Optional update script for automated version bumps
- Lockfiles when needed (e.g., `package-lock.json` for npm packages)

### Package Types and Build Patterns
The repository handles three main package types:
1. **Source packages**: Built from source using language-specific builders (`buildNpmPackage`, `rustPlatform.buildRustPackage`, etc.)
2. **Binary packages**: Pre-built binaries with `autoPatchelfHook` for Linux dynamic library handling
3. **Bytecode packages**: Interpreted/VM-based packages

### Key Infrastructure
- **Blueprint**: The flake uses numtide/blueprint for structure, configured in `flake.nix`
- **Treefmt**: Code formatting is handled by treefmt with configuration in `packages/formatter/treefmt.nix`
- **GitHub Actions**: Daily automated updates via `.github/workflows/update.yml` and `update-flake.yml`
- **Binary Cache**: Pre-built packages available from Numtide Cachix cache

### Special Packages
- **claudebox**: Experimental sandboxed wrapper for Claude Code demonstrating confined AI agent execution
- **claude-code-router**: Provider abstraction layer allowing Claude Code to work with different LLM backends

## Package Development Guidelines

### Adding a New Package
1. Create directory `packages/<tool-name>/`
2. Create `package.nix` with the derivation
3. Create `default.nix` with standard wrapper: `{ pkgs }: pkgs.callPackage ./package.nix { }`
4. Add update script if the package has predictable updates (npm, GitHub releases, etc.)
5. Ensure proper metadata (description, homepage, license, sourceProvenance)
6. Run `nix fmt` and `nix build .#<tool-name>` to verify

### Update Scripts
Update scripts should:
- Be idempotent and handle already-up-to-date cases
- Use `nix-prefetch-url` or similar for hash calculation
- Update both version and hash fields in `package.nix`
- Build the package to verify the update worked

### Common Patterns for Specific Languages
- **NPM packages**: Use `buildNpmPackage`, include `package-lock.json`, set `nodejs` version explicitly
- **Rust packages**: Use `rustPlatform.buildRustPackage`, handle cargo vendor issues
- **Binary packages**: Use `autoPatchelfHook` on Linux, set `dontUnpack = true` for single executables

## Troubleshooting Tips

### Build Failures
- Missing libraries: Add to `buildInputs` or `nativeBuildInputs`, common ones: `gcc-unwrapped.lib`
- Rust git dependencies: Consider using pre-built binaries if cargo vendoring fails
- NPM packages: Ensure `package-lock.json` is up-to-date and `npmDepsHash` is correct

### Testing Changes
- Always run `nix fmt` before committing
- Test package builds: `nix build .#<package-name>`
- Run full checks: `nix flake check`
- Test runtime: `nix run .#<package-name> -- --help`

## Commit Message Conventions
- Version updates: `<package>: <old-version> -> <new-version> (#PR)`
- New packages: `<package>: init at <version>`
- Infrastructure changes: Use appropriate prefix (e.g., `workflows:`, `formatter:`, `flake:`)