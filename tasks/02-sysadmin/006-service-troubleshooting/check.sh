#!/usr/bin/env bash
set -euo pipefail
if ! command -v systemctl >/dev/null 2>&1; then
  echo "systemctl not available on this system — this task needs a native host with systemd."
  exit 1
fi
if ! systemctl is-active --quiet webapp.service; then
  echo "webapp.service is still not active. Check 'systemctl status webapp' and 'journalctl -u webapp -n 50' for the real error."
  exit 1
fi
echo "webapp.service is active — good diagnosis."
