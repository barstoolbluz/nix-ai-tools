# nix-ai-tools (Flox Edition)

Flox-compatible Nix derivations for AI coding agents and related tools. Most packages delegate to [numtide/llm-agents.nix](https://github.com/numtide/llm-agents.nix) upstream (formerly `numtide/nix-ai-tools`); the rest are local derivations for tools numtide doesn't yet ship, or where we need custom patches, newer toolchains, or a different build strategy.

All builds are published to the [`flox/`](https://hub.flox.dev/catalog/flox) catalog on FloxHub across `x86_64-linux`, `aarch64-linux`, `x86_64-darwin`, and `aarch64-darwin` (minus a few packages that genuinely don't support every platform upstream).

## Contents

34 packages across five categories:

### Upstream-delegating (10)

Thin wrappers that import package definitions from numtide's repo. Version tracking happens by bumping `rev` + `hash` in `.flox/pkgs/fetch-upstream.nix` (automated — see [Automated updates](#automated-updates) below).

Some upstream packages rely on numtide-local helpers (`fetchNpmDepsWithPackuments`, `versionCheckHomeHook`, `wrapBuddy`) that don't exist in nixpkgs. We provide those via `.flox/pkgs/fetch-upstream-helpers.nix`, which callPackages them from the upstream source tree and threads them through to affected wrappers.

| Package | Description |
|---------|-------------|
| `claude-code-acp` | ACP (Agent Client Protocol) bridge for Claude Code |
| `code` | just-every's fork of Codex with multi-provider LLM support |
| `codex` | OpenAI's Codex terminal coding agent |
| `codex-acp` | ACP bridge for OpenAI Codex |
| `coderabbit-cli` | AI-powered code review CLI from CodeRabbit |
| `cursor-agent` | Headless coding agent from the Cursor IDE |
| `forge` | AI-enhanced terminal development environment |
| `kilocode-cli` | Kilocode's open-source AI coding agent |
| `openskills` | Framework for composable agent skills |
| `spec-kit` | GitHub's Spec-Driven Development toolkit |

### Local derivations — binary releases (16)

Pre-built release binaries downloaded from GitHub (or the vendor's own CDN), patched with `autoPatchelfHook` on Linux, and wrapped to include runtime dependencies on PATH. One `.nix` per package in `.flox/pkgs/`.

| Package | Description |
|---------|-------------|
| `backlog-md` | Markdown-driven project/task collaboration for humans and agents |
| `catnip` | Weights & Biases' developer environment for agentic programming |
| `claude-code` | Anthropic's agentic coding tool for the terminal |
| `claude-squad` | Run and manage multiple AI coding agents in parallel tmux sessions |
| `claurst` | Multi-provider terminal coding agent written in Rust |
| `codex-monitor` | Desktop app for orchestrating multiple Codex agents (AppImage / DMG) |
| `droid` | Factory AI's development agent |
| `eca` | Editor Code Assistant — editor-agnostic AI pair programming |
| `goose-cli` | Block's extensible open-source AI agent |
| `ironclaw` | Secure personal AI assistant in Rust, with optional pgvector store |
| `lmstudio` | Desktop app for running local / open-source LLMs (AppImage / DMG) |
| `mux` | Coder's desktop app for isolated, parallel agentic development |
| `nullclaw` | Autonomous AI assistant written in Zig — small and fast |
| `opencode` | SST's terminal AI coding agent (Bun-compiled binary) |
| `openhands` | Autonomous AI software-development agent |
| `zeroclaw` | Personal AI assistant infrastructure in Rust |

### Local derivations — source builds (4)

Built from source using `buildGoModule`, `rustPlatform.buildRustPackage`, or `buildNpmPackage`. Used where we need custom patches, a newer toolchain than upstream provides, or where no pre-built binaries are published.

| Package | Description |
|---------|-------------|
| `claw-code` | instructkr's Rust CLI for Claude with tool execution and session persistence |
| `code-package` | just-every/`code` built from source with workspace-version patches |
| `crush` | Charm's glamourous terminal AI coding agent (requires vendored Go 1.26.1) |
| `nanocoder` | Community-built local-first coding agent (pnpm / Bun) |

### Local derivations — bootstrap wrappers (3)

These don't build the underlying tool — they provide a wrapper that sets up a runtime environment on first invocation. Useful for tools with complex dependency graphs that fight Nix's hermeticity.

| Package | Description |
|---------|-------------|
| `claudebox` | Sandboxed shell environment for Claude Code (bubblewrap on Linux, seatbelt on macOS) |
| `hermes-agent` | Self-improving AI agent from Nous Research; installs into a `uv`-managed venv on first run |
| `open-interpreter` | Natural-language interface for computers; installs into a `uv`-managed venv on first run |

### Nixpkgs with override (1)

| Package | Description |
|---------|-------------|
| `openclaw` | Uses nixpkgs `openclaw` with `allowInsecurePredicate` to bypass `knownVulnerabilities` |

## Usage with Flox

```bash
# Build a package locally
flox build cursor-agent

# Test the result
./result-cursor-agent/bin/cursor-agent --version

# Publish to your own FloxHub catalog
flox publish cursor-agent

# Publish to an organization catalog
flox publish -o myorg cursor-agent
```

## Automated updates

This repo runs a daily auto-update pipeline that tracks upstream releases and keeps the FloxHub catalog fresh with no manual intervention for most packages.

**Workflow: [`.github/workflows/update-packages.yml`](.github/workflows/update-packages.yml)**

- Runs daily at 04:00 UTC (or on `workflow_dispatch` with an optional package filter)
- Reads [`.github/package-versions.json`](.github/package-versions.json) for per-package metadata: GitHub owner/repo, tag pattern, URL templates, per-platform asset names
- Queries the GitHub API for the latest release of each tracked package
- For outdated packages:
  - Prefetches the source artifacts with `nix-prefetch-url` on every platform
  - Computes SRI hashes and rewrites the `.nix` file via targeted `sed` / `awk`
  - Opens one PR per package
- PRs trigger [`build.yml`](.github/workflows/build.yml), which builds on `x86_64-linux`, `aarch64-linux`, and `macos-latest`
- On merge, [`publish.yml`](.github/workflows/publish.yml) rebuilds and publishes each changed package to the FloxHub catalog

The pipeline also handles dependency expansion: when `fetch-upstream.nix` changes, all 12 upstream-delegating packages are rebuilt and republished; when a vendored Go file changes, `crush` is rebuilt.

### Limitations

**Source-built packages with vendor hashes** (`crush`, `nanocoder`, `code-package`, `claw-code`) are not fully automated. When a new version is published, the auto-update workflow:

1. Bumps the `version` and source hash ✓
2. Sets `vendorHash` / `cargoHash` / `npmDepsHash` to a placeholder ✓
3. Opens a PR ✓
4. **Build fails** (by design) because the placeholder is wrong
5. You must build locally, copy the correct hash from the `got:` line in the error, commit it to the PR branch, and merge manually

This is intentional — there's no way to compute a Go/Rust/npm vendor hash without actually fetching dependencies, which the update workflow doesn't do. A future improvement could use a self-hosted runner or binary cache to close this gap.

**Desktop apps with no public release API** (`droid`, `lmstudio`) are marked `skip: true` in `package-versions.json` and don't participate in auto-updates. Bumps for these are manual.

## How it works

Packages fall into one of three patterns depending on how they're built:

**1. Upstream delegation** — a 5-line wrapper that imports from numtide:

```nix
{ callPackage, fetchFromGitHub }:
let
  upstream = import ./fetch-upstream.nix { inherit fetchFromGitHub; };
in
callPackage "${upstream}/packages/<tool>/package.nix" { }
```

**2. Local binary** — downloads a release artifact, patchelfs it on Linux, wraps it with PATH dependencies:

```nix
stdenv.mkDerivation {
  pname = "...";
  src = fetchurl { url = "..."; hash = "sha256-..."; };
  dontUnpack = true;  # or sourceRoot = ".";
  nativeBuildInputs = lib.optionals stdenv.isLinux [ autoPatchelfHook ];
  installPhase = ''install -m755 $src $out/bin/...'';
}
```

**3. Local source** — `buildGoModule` / `rustPlatform.buildRustPackage` / `buildNpmPackage` with whatever patches the upstream build needs.

See [CLAUDE.md](CLAUDE.md) for more detail on the patterns and where each package lives.

## Credits

- **Upstream package definitions**: [numtide/llm-agents.nix](https://github.com/numtide/llm-agents.nix) — the Numtide team maintains the 12 packages we delegate to (and also contributes many of them directly to nixpkgs).
- **Flox packaging, local derivations, and auto-update pipeline**: this repository.

## See also

- [CLAUDE.md](CLAUDE.md) — guidance for Claude Code and similar agents working in this repo
- [FLOX.md](FLOX.md) — detailed Flox usage guide
- [FLOX-PACKAGING.md](FLOX-PACKAGING.md) — packaging workflow documentation
- [numtide/llm-agents.nix](https://github.com/numtide/llm-agents.nix) — upstream repository (formerly `numtide/nix-ai-tools`)
- [Flox](https://flox.dev) — reproducible environments and builds backed by Nix

## License

Individual tools are licensed under their respective licenses (see each package's `meta.license`). The Nix/Flox packaging code in this repository is MIT-licensed.
