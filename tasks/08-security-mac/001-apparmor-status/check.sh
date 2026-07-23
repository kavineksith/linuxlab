#!/usr/bin/env bash
set -euo pipefail
if ! command -v aa-status >/dev/null 2>&1; then
  echo "AppArmor tools not installed — this task needs a native Debian/Ubuntu host with apparmor-utils."
  exit 1
fi
status="$(sudo aa-status 2>/dev/null || aa-status 2>/dev/null || true)"
if [ -z "$status" ]; then
  echo "Could not read AppArmor status (permissions?)."
  exit 1
fi
if echo "$status" | grep -A100 'profiles are in enforce mode' | grep -q 'labguard'; then
  echo "labguard is correctly enforced."
elif echo "$status" | grep -q 'labguard'; then
  echo "labguard profile is loaded but not in enforce mode yet. Try: sudo aa-enforce /usr/sbin/labguard"
  exit 1
else
  echo "labguard profile not found in aa-status output — run 'lab start' first."
  exit 1
fi
