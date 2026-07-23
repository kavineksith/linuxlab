#!/usr/bin/env bash
set -euo pipefail
mkdir -p "$HOME/labwork"
sudo umount /mnt/labdata 2>/dev/null || true
sudo vgremove -f labvg 2>/dev/null || true
sudo losetup -d /dev/loop20 2>/dev/null || true
sudo losetup -d /dev/loop21 2>/dev/null || true
fallocate -l 60M "$HOME/labwork/pv1.img"
fallocate -l 60M "$HOME/labwork/pv2.img"
sudo losetup /dev/loop20 "$HOME/labwork/pv1.img" 2>/dev/null || sudo losetup -f "$HOME/labwork/pv1.img"
sudo losetup /dev/loop21 "$HOME/labwork/pv2.img" 2>/dev/null || sudo losetup -f "$HOME/labwork/pv2.img"
sudo mkdir -p /mnt/labdata
echo "Two 60MB loop devices are ready (check 'losetup -a' for exact paths). Build labvg on top of them."
