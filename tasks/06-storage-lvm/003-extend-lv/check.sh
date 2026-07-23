#!/usr/bin/env bash
set -euo pipefail
if ! command -v lvs >/dev/null 2>&1; then
  echo "LVM tools not installed — this task needs lvm2 on a native host."
  exit 1
fi
if ! sudo lvs labvg/datalv >/dev/null 2>&1; then
  echo "labvg/datalv not found — complete 'lvm-basics' first."
  exit 1
fi
size_mb=$(sudo lvs --noheadings --units m -o lv_size labvg/datalv 2>/dev/null | tr -dc '0-9.' | cut -d. -f1)
if [ -z "$size_mb" ] || [ "$size_mb" -lt 65 ]; then
  echo "datalv is still only about ${size_mb:-?}M — expected roughly 70M after extending."
  exit 1
fi
mnt="$(findmnt -n -o SOURCE /mnt/labdata 2>/dev/null || true)"
if [ -z "$mnt" ]; then
  echo "/mnt/labdata is not mounted — did the resize survive?"
  exit 1
fi
avail_kb=$(df --output=size -k /mnt/labdata 2>/dev/null | tail -n1 | tr -d ' ')
if [ -n "$avail_kb" ] && [ "$avail_kb" -lt 60000 ]; then
  echo "The filesystem on /mnt/labdata doesn't reflect the larger size yet — did you run resize2fs?"
  exit 1
fi
echo "datalv extended and filesystem resized online — no downtime."
