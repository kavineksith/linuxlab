#!/usr/bin/env bash
set -euo pipefail
mnt="$(findmnt -n -o SOURCE /mnt/labdisk 2>/dev/null || true)"
if [ -z "$mnt" ]; then
  echo "/mnt/labdisk is not currently mounted — complete 'loop-filesystem' first, or remount it."
  exit 1
fi
uuid="$(sudo blkid -s UUID -o value "$mnt" 2>/dev/null || blkid -s UUID -o value "$mnt" 2>/dev/null || true)"
if [ -z "$uuid" ]; then
  echo "Could not determine UUID of $mnt."
  exit 1
fi
if ! grep -q "UUID=$uuid" /etc/fstab 2>/dev/null; then
  echo "/etc/fstab does not contain an entry for UUID=$uuid"
  exit 1
fi
if ! grep -E "UUID=$uuid\s+/mnt/labdisk\s+ext4" /etc/fstab >/dev/null 2>&1; then
  echo "fstab has that UUID, but the mountpoint or filesystem type looks wrong. Expected: UUID=$uuid /mnt/labdisk ext4 defaults 0 2"
  exit 1
fi
if ! sudo mount -a 2>/tmp/mount_a_err; then
  echo "'sudo mount -a' reported an error:"
  cat /tmp/mount_a_err
  exit 1
fi
echo "fstab entry is correct and 'mount -a' succeeds cleanly."
