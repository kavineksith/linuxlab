#!/usr/bin/env bash
set -euo pipefail
if ! command -v systemctl >/dev/null 2>&1; then
  echo "systemctl not available — this task needs a native host with systemd."
  exit 1
fi
UNIT=/etc/systemd/system/labdemo.service
[ -f "$UNIT" ] || { echo "$UNIT not found — run 'lab start' first."; exit 1; }
ok=1
grep -qE '^MemoryMax=100M' "$UNIT" || { echo "MemoryMax=100M not found in the unit file."; ok=0; }
grep -qE '^CPUQuota=50%' "$UNIT" || { echo "CPUQuota=50% not found in the unit file."; ok=0; }

show="$(systemctl show labdemo.service -p MemoryMax -p CPUQuotaPerSecUSec 2>/dev/null || true)"
echo "$show" | grep -q '^MemoryMax=104857600' || { echo "Running unit does not report a 100M MemoryMax — did you daemon-reload and restart?"; ok=0; }

systemctl is-active --quiet labdemo.service || { echo "labdemo.service is not active."; ok=0; }

[ "$ok" -eq 1 ] && echo "Resource limits are correctly applied to labdemo.service."
[ "$ok" -eq 1 ]
