#!/usr/bin/env bash
set -euo pipefail
if [ ! -d old_logs ]; then
  echo "old_logs/ directory is missing — it should be pruned of old files, not deleted itself."
  exit 1
fi
old_left=$(find old_logs -name '*.log' -mtime +14 | wc -l)
recent_left=$(find old_logs -name '*.log' -mtime -14 | wc -l)
ok=1
[ "$old_left" -eq 0 ] || { echo "$old_left file(s) older than 14 days still remain in old_logs/."; ok=0; }
[ "$recent_left" -eq 3 ] || { echo "Expected 3 recent files to remain, found $recent_left. Did you delete too much?"; ok=0; }
[ "$ok" -eq 1 ] && echo "old_logs/ pruned correctly — old logs gone, recent logs kept."
[ "$ok" -eq 1 ]
