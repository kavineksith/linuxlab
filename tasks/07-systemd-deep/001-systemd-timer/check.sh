#!/usr/bin/env bash
set -euo pipefail
if ! command -v systemctl >/dev/null 2>&1; then
  echo "systemctl not available — this task needs a native host with systemd."
  exit 1
fi
ok=1
[ -f /etc/systemd/system/labjob.service ] || { echo "labjob.service unit file missing."; ok=0; }
[ -f /etc/systemd/system/labjob.timer ] || { echo "labjob.timer unit file missing."; ok=0; }
if [ -f /etc/systemd/system/labjob.timer ]; then
  grep -q '^OnCalendar=' /etc/systemd/system/labjob.timer || { echo "labjob.timer has no OnCalendar= directive."; ok=0; }
  grep -q '^WantedBy=timers.target' /etc/systemd/system/labjob.timer || { echo "labjob.timer missing WantedBy=timers.target."; ok=0; }
fi
systemctl is-enabled --quiet labjob.timer 2>/dev/null || { echo "labjob.timer is not enabled."; ok=0; }
systemctl is-active --quiet labjob.timer 2>/dev/null || { echo "labjob.timer is not active."; ok=0; }
[ "$ok" -eq 1 ] && echo "labjob.timer is correctly defined, enabled, and active."
[ "$ok" -eq 1 ]
