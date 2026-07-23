#!/usr/bin/env bash
set -euo pipefail
if ! command -v systemctl >/dev/null 2>&1; then
  echo "systemctl not available — this task needs a native host with systemd."
  exit 1
fi
ok=1
FE=/etc/systemd/system/labfrontend.service
BE=/etc/systemd/system/labbackend.service
[ -f "$BE" ] || { echo "labbackend.service missing."; ok=0; }
[ -f "$FE" ] || { echo "labfrontend.service missing."; ok=0; }
if [ -f "$FE" ]; then
  grep -q '^After=labbackend.service' "$FE" || { echo "labfrontend.service missing After=labbackend.service."; ok=0; }
  grep -q '^Requires=labbackend.service' "$FE" || { echo "labfrontend.service missing Requires=labbackend.service."; ok=0; }
fi
systemctl is-active --quiet labbackend.service || { echo "labbackend.service is not active."; ok=0; }
systemctl is-active --quiet labfrontend.service || { echo "labfrontend.service is not active."; ok=0; }
[ "$ok" -eq 1 ] && echo "Dependency ordering is correctly configured and both services are active."
[ "$ok" -eq 1 ]
