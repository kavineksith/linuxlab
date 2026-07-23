#!/usr/bin/env bash
set -euo pipefail
if ! command -v crontab >/dev/null 2>&1; then
  echo "crontab command not found on this system — this task needs a native host with cron installed."
  exit 1
fi
cron_content="$(crontab -l 2>/dev/null || true)"
if [ -z "$cron_content" ]; then
  echo "No crontab entries found for this user. Use 'crontab -e' to add one."
  exit 1
fi
if echo "$cron_content" | grep -qE '^30[[:space:]]+2[[:space:]]+\*[[:space:]]+\*[[:space:]]+\*[[:space:]]+find /tmp/labcleanup -type f -mtime \+7 -delete'; then
  echo "Cron entry found and correctly scheduled for 2:30 AM daily."
else
  echo "No matching cron entry found. It must run at 2:30 AM daily and match exactly:"
  echo "  30 2 * * * find /tmp/labcleanup -type f -mtime +7 -delete"
  exit 1
fi
