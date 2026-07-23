#!/usr/bin/env bash
set -euo pipefail
PROFILE=/etc/apparmor.d/usr.local.bin.labreader
if ! command -v aa-status >/dev/null 2>&1; then
  echo "AppArmor tools not installed — this task needs a native Debian/Ubuntu host with apparmor-utils."
  exit 1
fi
[ -f "$PROFILE" ] || { echo "$PROFILE not found."; exit 1; }
ok=1
grep -q '/var/lab/data/\*\*' "$PROFILE" || { echo "Profile doesn't grant access to /var/lab/data/**"; ok=0; }
grep -qE '/var/lab/data/\*\*\s+r' "$PROFILE" || { echo "Profile doesn't grant read (r) access to /var/lab/data/**"; ok=0; }
grep -qE '/var/lab/data/\*\*\s+.*w' "$PROFILE" && { echo "Profile grants write access — it should be read-only."; ok=0; }

status="$(sudo aa-status 2>/dev/null || aa-status 2>/dev/null || true)"
echo "$status" | grep -A200 'profiles are in enforce mode' | grep -q 'labreader' || { echo "labreader profile is not enforced yet."; ok=0; }

[ "$ok" -eq 1 ] && echo "labreader is correctly confined to read-only access under /var/lab/data/."
[ "$ok" -eq 1 ]
