#!/usr/bin/env bash
set -euo pipefail
FILE=/etc/logrotate.d/labapp
if ! command -v logrotate >/dev/null 2>&1; then
  echo "logrotate not installed — this task needs a native host with logrotate."
  exit 1
fi
if [ ! -f "$FILE" ]; then
  echo "$FILE does not exist."
  exit 1
fi
ok=1
grep -q '/var/log/labapp.log' "$FILE" || { echo "Config doesn't reference /var/log/labapp.log."; ok=0; }
grep -qE '(^|\s)weekly(\s|$)' "$FILE" || { echo "Missing 'weekly' directive."; ok=0; }
grep -qE 'rotate\s+4' "$FILE" || { echo "Missing 'rotate 4' directive."; ok=0; }
grep -qE '(^|\s)compress(\s|$)' "$FILE" || { echo "Missing 'compress' directive."; ok=0; }

if sudo logrotate -d "$FILE" >/tmp/lrtest 2>&1 || logrotate -d "$FILE" >/tmp/lrtest 2>&1; then
  :
fi
if grep -qi 'error' /tmp/lrtest 2>/dev/null; then
  echo "logrotate -d reports an error in the config:"
  cat /tmp/lrtest
  ok=0
fi

[ "$ok" -eq 1 ] && echo "logrotate config for labapp is correct."
[ "$ok" -eq 1 ]
