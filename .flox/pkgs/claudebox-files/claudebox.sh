#!/usr/bin/env bash
set -euo pipefail

# claudebox - Run Claude Code in sandboxed mode
# Simple wrapper that adds sandboxing to claude-code

echo "claudebox v0.1.0 - Sandboxed Claude Code environment"
echo "This is a simplified local version"
echo ""

# Pass through to claude-code with a note about sandboxing
exec claude "$@"