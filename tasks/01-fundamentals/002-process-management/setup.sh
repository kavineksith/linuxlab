#!/usr/bin/env bash
set -euo pipefail
# Launch a harmless background sleep loop under a recognizable name via exec -a
pkill -f lab_runaway_proc >/dev/null 2>&1 || true
nohup bash -c 'exec -a lab_runaway_proc bash -c "while true; do sleep 2; done"' >/dev/null 2>&1 &
disown
sleep 1
echo "Started background process 'lab_runaway_proc' (pid $(pgrep -f lab_runaway_proc | head -n1))"
