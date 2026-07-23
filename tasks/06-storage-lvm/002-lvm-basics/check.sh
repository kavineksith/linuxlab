#!/usr/bin/env bash
set -euo pipefail
if ! command -v lvs >/dev/null 2>&1; then
  echo "LVM tools not installed — this task needs lvm2 on a native host."
  exit 1
fi
ok=1
sudo vgs labvg >/dev/null 2>&1 || { echo "Volume group 'labvg' not found."; ok=0; }
sudo lvs labvg/datalv >/dev/null 2>&1 || { echo "Logical volume 'labvg/datalv' not found."; ok=0; }
pvcount=$(sudo vgs --noheadings -o pv_count labvg 2>/dev/null | tr -d ' ' || echo 0)
[ "$pvcount" = "2" ] || { echo "Expected labvg to have 2 physical volumes, found $pvcount."; ok=0; }
mnt="$(findmnt -n -o SOURCE,FSTYPE /mnt/labdata 2>/dev/null || true)"
if [ -z "$mnt" ]; then
  echo "/mnt/labdata is not mounted."
  ok=0
else
  echo "$mnt" | grep -qi 'labvg-datalv\|labvg/datalv' || echo "(note: mount source is $mnt — double-check it's your LV)"
  echo "$mnt" | grep -q ext4 || { echo "/mnt/labdata is not formatted ext4."; ok=0; }
fi
[ "$ok" -eq 1 ] && echo "labvg/datalv is correctly built, formatted, and mounted."
[ "$ok" -eq 1 ]
