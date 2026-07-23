#!/usr/bin/env bash
set -euo pipefail
mkdir -p "$HOME/labwork"
sudo umount /mnt/labdisk 2>/dev/null || true
sudo losetup -D 2>/dev/null || true
sudo mkdir -p /mnt/labdisk
echo "Workspace ready. Build your loop-device filesystem now."
