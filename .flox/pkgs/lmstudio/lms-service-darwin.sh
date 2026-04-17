#!/usr/bin/env bash
set -euo pipefail
# lms-service — headless LM Studio service launcher (macOS)
#
# Placeholders replaced at build time by substituteInPlace:
#   @lms@          — .lms-unwrapped binary
#   @lm_studio@    — lm-studio wrapper

# Ensure lms can find the Electron binary
config_dir="${HOME}/.lmstudio/.internal"
mkdir -p "$config_dir"
echo '{"installLocation":"@lm_studio@"}' > "$config_dir/app-install-location.json"

# Clean stale daemon state
@lms@ daemon down 2>/dev/null || true

# Set up logging
log_dir="${LMS_LOG_DIR:-$HOME/.lmstudio/logs}"
mkdir -p "$log_dir"

echo "Starting LM Studio service..."
exec @lm_studio@ --run-as-service >> "$log_dir/lm-studio.log" 2>&1
