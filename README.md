# nix-ai-tools (Flox Edition)

Flox build recipes for AI coding agents not yet available in nixpkgs-unstable or the Flox catalog.

This repository provides [Flox](https://flox.dev)-compatible Nix expressions that leverage the excellent packaging work from [numtide/nix-ai-tools](https://github.com/numtide/nix-ai-tools). All credit for the upstream package definitions goes to the Numtide team.

## What's Here

The `.flox/pkgs/` directory contains build recipes for 20 AI coding tools:

| Package | Description |
|---------|-------------|
| `backlog-md` | Project collaboration between humans and AI agents |
| `catnip` | Developer environment for agentic programming |
| `claude-code-acp` | ACP-compatible agent powered by Claude Code SDK |
| `claude-desktop` | Claude Desktop AI assistant |
| `claudebox` | Sandboxed environment for Claude Code |
| `code` | Fork of Codex supporting multiple LLM providers |
| `coderabbit-cli` | AI-powered code review CLI |
| `codex` | OpenAI Codex CLI coding agent |
| `codex-acp` | ACP-compatible agent powered by Codex |
| `crush` | The glamourous AI coding agent for your favourite terminal |
| `cursor-agent` | CLI tool for Cursor AI |
| `droid` | Factory AI's development agent |
| `eca` | Editor Code Assistant for AI pair programming |
| `forge` | AI-enhanced terminal development environment |
| `goose-cli` | Block's extensible AI agent |
| `groq-code-cli` | Coding CLI powered by Groq |
| `kilocode-cli` | Open-source AI coding agent |
| `nanocoder` | Local-first coding agent |
| `opencode` | Terminal-based AI coding agent |
| `spec-kit` | GitHub Spec Kit for Spec-Driven Development |

## Usage with Flox

```bash
# Build a package
flox build cursor-agent

# Publish to your catalog
flox publish cursor-agent

# Or publish to an organization
flox publish -o myorg cursor-agent
```

## How It Works

Most packages delegate to the upstream [numtide/nix-ai-tools](https://github.com/numtide/nix-ai-tools) repository:

```nix
{ callPackage, fetchFromGitHub }:
let
  upstream = import ../lib/fetch-upstream.nix { inherit fetchFromGitHub; };
in
callPackage "${upstream}/packages/<tool>/package.nix" { }
```

Some packages (like `opencode.nix` and `goose-cli.nix`) have custom local derivations where additional modifications were needed.

## Branch Strategy

This repository uses a three-branch strategy:
- **`main`** - Stable versions using standard nixpkgs toolchains
- **`nightly`** - Latest upstream versions, may vendor newer toolchains (e.g., Go versions not yet in nixpkgs)
- **`historical`** - Previous stable versions for compatibility

The nightly branch includes vendored Go when packages require versions newer than nixpkgs provides.

## Upstream Sync

To update to the latest upstream package definitions:

```bash
# Update the rev/hash in .flox/pkgs/fetch-upstream.nix
# Then rebuild packages
flox build <package>
```

## Credits

- **Package definitions**: [numtide/nix-ai-tools](https://github.com/numtide/nix-ai-tools)
- **Flox packaging**: This repository

## See Also

- [FLOX.md](FLOX.md) - Detailed Flox usage guide
- [FLOX-PACKAGING.md](FLOX-PACKAGING.md) - Packaging workflow documentation
- [numtide/nix-ai-tools](https://github.com/numtide/nix-ai-tools) - Upstream repository

## License

Individual tools are licensed under their respective licenses. The Nix/Flox packaging code in this repository is licensed under MIT.
