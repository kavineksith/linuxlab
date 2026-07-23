#!/usr/bin/env bash
set -euo pipefail
if ! command -v systemctl >/dev/null 2>&1; then
  echo "systemctl not available — this task needs a native host with systemd."
  exit 1
fi
ok=1
SCRIPT=/usr/local/bin/lab-nightly-backup.sh
[ -x "$SCRIPT" ] || { echo "$SCRIPT missing or not executable."; ok=0; }
[ -f /etc/systemd/system/lab-nightly-backup.service ] || { echo "lab-nightly-backup.service unit missing."; ok=0; }
[ -f /etc/systemd/system/lab-nightly-backup.timer ] || { echo "lab-nightly-backup.timer unit missing."; ok=0; }
if [ -f /etc/systemd/system/lab-nightly-backup.timer ]; then
  grep -q '^OnCalendar=' /etc/systemd/system/lab-nightly-backup.timer || { echo "Timer missing OnCalendar=."; ok=0; }
  grep -q '^WantedBy=timers.target' /etc/systemd/system/lab-nightly-backup.timer || { echo "Timer missing WantedBy=timers.target."; ok=0; }
fi
systemctl is-enabled --quiet lab-nightly-backup.timer 2>/dev/null || { echo "Timer is not enabled."; ok=0; }

count_before=$(ls /var/backups/labdata-*.tar.gz 2>/dev/null | wc -l)
sudo systemctl start lab-nightly-backup.service 2>/dev/null || systemctl start lab-nightly-backup.service 2>/dev/null || true
sleep 1
count_after=$(ls /var/backups/labdata-*.tar.gz 2>/dev/null | wc -l)
if [ "$count_after" -le "$count_before" ] && [ "$count_after" -eq 0 ]; then
  echo "Running the service did not produce a backup archive under /var/backups/."
  ok=0
fi

[ "$ok" -eq 1 ] && echo "Backup script, service, and timer are all correctly wired up and working."
[ "$ok" -eq 1 ]
