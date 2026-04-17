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

cleanup() {
  @lms@ server stop 2>/dev/null || true
  @lms@ daemon down 2>/dev/null || true
}
trap cleanup EXIT TERM INT

echo "Starting LM Studio service..."
@lm_studio@ --run-as-service >> "$log_dir/lm-studio.log" 2>&1 &

# Wait for app to initialize, then start the API server
sleep 10
attempts=0
while [ "$attempts" -lt 30 ]; do
  if @lms@ server start >> "$log_dir/lm-studio.log" 2>&1; then
    echo "LM Studio API server started"
    break
  fi
  attempts=$((attempts + 1))
  sleep 2
done

# Keep the service alive — sleep in a loop so flox can manage the process.
# On SIGTERM (flox services stop), the trap fires and cleans up.
while true; do sleep 86400; done
