#!/usr/bin/env bash
set -euo pipefail
UNIT=/etc/systemd/system/labdemo.service
if ! command -v systemctl >/dev/null 2>&1; then
  echo "systemctl not available on this system — this task needs a native host with systemd."
  exit 1
fi
if [ ! -f "$UNIT" ]; then
  echo "$UNIT does not exist."
  exit 1
fi
ok=1
grep -q '^ExecStart=/usr/bin/sleep infinity' "$UNIT" || { echo "ExecStart line missing or incorrect."; ok=0; }
grep -q '^Restart=on-failure' "$UNIT" || { echo "Restart=on-failure missing."; ok=0; }
grep -q '^WantedBy=multi-user.target' "$UNIT" || { echo "WantedBy=multi-user.target missing from [Install]."; ok=0; }
if ! systemctl is-active --quiet labdemo.service; then
  echo "labdemo.service is not active. Did you run 'systemctl start labdemo'?"
  ok=0
fi
if ! systemctl is-enabled --quiet labdemo.service; then
  echo "labdemo.service is not enabled. Did you run 'systemctl enable labdemo'?"
  ok=0
fi
[ "$ok" -eq 1 ] && echo "labdemo.service is correctly defined, enabled, and running."
[ "$ok" -eq 1 ]
