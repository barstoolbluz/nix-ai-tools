#!/usr/bin/env bash
set -euo pipefail
# lms-service — headless LM Studio service launcher (Linux)
#
# Placeholders replaced at build time by substituteInPlace:
#   @lms@          — .lms-unwrapped binary (with LD_LIBRARY_PATH set below)
#   @lm_studio@    — lm-studio AppImage wrapper
#   @xvfb@         — Xvfb binary
#   @lib_path@     — LD_LIBRARY_PATH for .lms-unwrapped

export LD_LIBRARY_PATH="@lib_path@${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"

# Ensure lms can find the Electron binary
config_dir="${HOME}/.lmstudio/.internal"
mkdir -p "$config_dir"
echo '{"installLocation":"@lm_studio@"}' > "$config_dir/app-install-location.json"

# Find a free display number for Xvfb
display_num=99
while [ -e "/tmp/.X${display_num}-lock" ] && [ "$display_num" -lt 200 ]; do
  display_num=$((display_num + 1))
done
export DISPLAY=":$display_num"

# Start Xvfb (Electron requires X even in headless mode)
@xvfb@ "$DISPLAY" -screen 0 1024x768x24 -nolisten tcp &
xvfb_pid=$!

cleanup() {
  @lms@ server stop 2>/dev/null || true
  @lms@ daemon down 2>/dev/null || true
  kill "$xvfb_pid" 2>/dev/null || true
}
trap cleanup EXIT TERM INT

sleep 0.5

# Clean stale daemon state
@lms@ daemon down 2>/dev/null || true

# Set up logging
log_dir="${LMS_LOG_DIR:-$HOME/.lmstudio/logs}"
mkdir -p "$log_dir"

# Start LM Studio app in the background.
# On Linux the AppImage wrapper invokes bwrap which stays alive as a child,
# so we must background it to reach the polling loop below.
@lm_studio@ --run-as-service >> "$log_dir/lm-studio.log" 2>&1 &

# Wait for app to initialize, then start the API server
sleep 10
attempts=0
while [ "$attempts" -lt 30 ]; do
  if @lms@ server start >> "$log_dir/lm-studio.log" 2>&1; then
    echo "LM Studio API server started on DISPLAY=$DISPLAY"
    break
  fi
  attempts=$((attempts + 1))
  sleep 2
done

# Keep the service alive — sleep in a loop so flox can manage the process.
# On SIGTERM (flox services stop), the trap fires and cleans up.
while true; do sleep 86400; done
