#!/usr/bin/env bash
set -euo pipefail
if ! command -v ufw >/dev/null 2>&1; then
  echo "ufw not installed — this task needs a native host with ufw."
  exit 1
fi
status="$(sudo ufw status verbose 2>/dev/null || ufw status verbose 2>/dev/null || true)"
if [ -z "$status" ]; then
  echo "Could not read ufw status (are you running with sudo access?)."
  exit 1
fi
ok=1
echo "$status" | grep -qi "Status: active" || { echo "ufw is not active. Run: sudo ufw enable"; ok=0; }
echo "$status" | grep -qi "Default: deny (incoming)" || { echo "Default incoming policy is not 'deny'."; ok=0; }
echo "$status" | grep -qE "22/tcp\s+ALLOW" || { echo "Port 22/tcp is not allowed."; ok=0; }
echo "$status" | grep -qE "8080/tcp\s+ALLOW" || { echo "Port 8080/tcp is not allowed."; ok=0; }
[ "$ok" -eq 1 ] && echo "Firewall is correctly locked down."
[ "$ok" -eq 1 ]
