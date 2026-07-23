#!/usr/bin/env bash
set -euo pipefail
if ! id tempuser >/dev/null 2>&1; then
  echo "'tempuser' account does not exist — run 'lab start' first."
  exit 1
fi
info="$(sudo chage -l tempuser 2>/dev/null || chage -l tempuser 2>/dev/null || true)"
if [ -z "$info" ]; then
  echo "Could not read chage info for tempuser (permissions issue?)."
  exit 1
fi
ok=1
echo "$info" | grep -qE 'Maximum number of days between password change.*: 30' || { echo "Maximum password age is not 30 days."; ok=0; }
echo "$info" | grep -qE 'Minimum number of days between password change.*: 1' || { echo "Minimum password age is not 1 day."; ok=0; }
echo "$info" | grep -qE 'Number of days of warning before password expires.*: 7' || { echo "Warning period is not 7 days."; ok=0; }
[ "$ok" -eq 1 ] && echo "Password aging policy correctly configured for tempuser."
[ "$ok" -eq 1 ]
