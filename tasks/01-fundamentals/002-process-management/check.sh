#!/usr/bin/env bash
set -euo pipefail
if pgrep -f lab_runaway_proc >/dev/null 2>&1; then
  echo "lab_runaway_proc is still running (pid $(pgrep -f lab_runaway_proc | head -n1)). Kill it."
  exit 1
fi
echo "No lab_runaway_proc process found — nicely done."
