#!/usr/bin/env bash
set -euo pipefail
IMG="$HOME/labwork/disk.img"
ok=1
[ -f "$IMG" ] || { echo "$IMG not found."; ok=0; }
if [ -f "$IMG" ]; then
  size=$(stat -c '%s' "$IMG")
  [ "$size" -ge 95000000 ] && [ "$size" -le 110000000 ] || { echo "$IMG is not ~100MB (found $size bytes)."; ok=0; }
fi
if ! command -v losetup >/dev/null 2>&1; then
  echo "losetup not available on this system."
  exit 1
fi
mnt="$(findmnt -n -o SOURCE,FSTYPE /mnt/labdisk 2>/dev/null || true)"
if [ -z "$mnt" ]; then
  echo "/mnt/labdisk is not mounted."
  ok=0
else
  echo "$mnt" | grep -q ext4 || { echo "/mnt/labdisk is mounted but not as ext4 ($mnt)."; ok=0; }
fi
[ "$ok" -eq 1 ] && echo "Loop-backed ext4 filesystem is correctly built and mounted."
[ "$ok" -eq 1 ]
