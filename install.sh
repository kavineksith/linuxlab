#!/usr/bin/env bash
# install.sh — installs linuxlab on a Debian-based host (Debian, Ubuntu, Linux Mint)
#
# Usage:
#   sudo ./install.sh
#
# What it does:
#   - Installs a small set of packages the tasks rely on
#   - Copies this project to /opt/linuxlab
#   - Symlinks the 'lab' command into /usr/local/bin
#
# Safe to re-run; it just overwrites /opt/linuxlab with the current copy.

set -euo pipefail

if [ "$(id -u)" -ne 0 ]; then
  echo "Please run this with sudo: sudo ./install.sh" >&2
  exit 1
fi

if ! command -v apt-get >/dev/null 2>&1; then
  echo "apt-get not found. This installer targets Debian-based systems" \
       "(Debian, Ubuntu, Linux Mint). Aborting." >&2
  exit 1
fi

echo "==> Installing dependencies..."
apt-get update -y
apt-get install -y --no-install-recommends \
  cron \
  sudo \
  coreutils \
  findutils \
  grep \
  gawk \
  sed \
  procps \
  psmisc \
  iproute2 \
  net-tools \
  openssh-server \
  ufw \
  vim-tiny \
  nano \
  less \
  curl \
  ca-certificates \
  python3 \
  netcat-openbsd \
  dnsutils \
  logrotate \
  file \
  rsync \
  lvm2 \
  apparmor \
  apparmor-utils \
  auditd

SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST_DIR="/opt/linuxlab"

echo "==> Installing linuxlab to $DEST_DIR ..."
rm -rf "$DEST_DIR"
mkdir -p "$DEST_DIR"
cp -a "$SRC_DIR"/. "$DEST_DIR"/

chmod +x "$DEST_DIR/bin/lab"
find "$DEST_DIR/tasks" \( -name 'setup.sh' -o -name 'check.sh' \) -exec chmod +x {} \;

ln -sf "$DEST_DIR/bin/lab" /usr/local/bin/lab

echo
echo "==> Done. linuxlab is installed."
echo "    Run 'lab list' to see available tasks."
echo "    Run 'lab progress' anytime to see your progress."
echo
echo "Note: some tasks modify real system state (users, groups, sudoers,"
echo "cron, firewall). Only run this on a disposable VM or lab machine —"
echo "not your primary workstation."
