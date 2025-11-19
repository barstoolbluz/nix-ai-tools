# Flox Packaging for nix-ai-tools

This fork adds Flox packaging support for AI coding tools from the upstream [numtide/nix-ai-tools](https://github.com/numtide/nix-ai-tools) repository.

## Repository Structure

This fork tracks:
- ✅ `.flox/` - Flox packaging definitions (Nix expressions)
- ✅ `flake.nix`, `flake.lock` - Your Nix flake configuration
- ✅ `FLOX.md` - Flox usage documentation
- ✅ `CLAUDE.md` - Claude Code instructions
- ❌ `packages/` - NOT tracked (synced from upstream)

## How It Works

The `packages/` directory contains package definitions from upstream but is **not tracked** in this fork. Instead:

1. We sync `packages/` from upstream periodically via git merge
2. `.flox/pkgs/*.nix` files reference these package definitions
3. We only commit changes to `.flox/`, flake files, and documentation

## Workflow

### Initial Setup
```bash
# Clone your fork
git clone https://github.com/barstoolbluz/nix-ai-tools.git
cd nix-ai-tools

# Add upstream remote
git remote add upstream https://github.com/numtide/nix-ai-tools.git

# Fetch upstream packages (first time)
git fetch upstream main
git checkout upstream/main -- packages/
```

### Syncing with Upstream
```bash
# Pull latest package definitions from upstream
git fetch upstream main
git checkout upstream/main -- packages/

# Or merge everything from upstream
git merge upstream/main
```

### Working on Flox Packaging
```bash
# Make changes to .flox/ files
vi .flox/pkgs/some-tool.nix

# Commit only Flox-related changes
git add .flox/ FLOX.md CLAUDE.md flake.nix
git commit -m "Update Flox packaging"
git push origin main
```

### Publishing Packages
```bash
# Build a package
flox build cursor-agent

# Publish to your Flox catalog
flox publish cursor-agent

# Or publish to an organization
flox publish -o myorg cursor-agent
```

## Available Packages

### Already in Flox Catalog
These tools are already available via `flox install`:
- claude-code
- claude-code-acp
- claude-code-router
- opencode
- gemini-cli
- goose-cli
- github-copilot-cli
- crush
- amp-cli
- qwen-code

### Packaged Here (16 tools)
These tools are **not** in the Flox catalog and are packaged in `.flox/pkgs/`:
- cursor-agent
- droid
- forge
- nanocoder
- catnip
- coderabbit-cli
- code
- kilocode-cli
- groq-code-cli
- eca
- backlog-md
- claudebox
- claude-desktop
- codex
- codex-acp
- spec-kit

## Maintenance

### Update Upstream Package Definitions
```bash
git fetch upstream main
git merge upstream/main
# Resolve any conflicts (should be minimal since packages/ is not tracked)
```

### Fix Broken Packages
If upstream changes break a Flox package:
```bash
# Edit the Flox wrapper
vi .flox/pkgs/broken-tool.nix

# Test the fix
flox build broken-tool

# Commit
git add .flox/pkgs/broken-tool.nix
git commit -m "Fix broken-tool Flox packaging"
```

## Why This Approach?

1. **Lightweight fork**: Only tracks Flox-specific additions
2. **Easy sync**: `git merge upstream/main` pulls latest packages
3. **No duplication**: Package definitions live in one place (upstream)
4. **Clean separation**: Your Flox packaging vs upstream package maintenance
5. **Working builds**: `packages/` exists locally for Flox to reference

## See Also

- [FLOX.md](FLOX.md) - Complete Flox usage guide
- [CLAUDE.md](CLAUDE.md) - Claude Code development instructions
- [Upstream repo](https://github.com/numtide/nix-ai-tools) - Original package repository
