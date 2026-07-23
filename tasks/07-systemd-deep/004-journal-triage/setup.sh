#!/usr/bin/env bash
set -euo pipefail
tmp="$(mktemp)"
cat > "$tmp" <<'UNIT'
[Unit]
Description=Lab crasher demo

[Service]
ExecStart=/bin/bash -c 'echo "FATAL: missing config at /etc/labcrasher.conf" >&2; exit 1'
Restart=on-failure
RestartSec=2
UNIT
sudo cp "$tmp" /etc/systemd/system/labcrasher.service 2>/dev/null || cp "$tmp" /etc/systemd/system/labcrasher.service
rm -f "$tmp"
sudo systemctl daemon-reload 2>/dev/null || systemctl daemon-reload 2>/dev/null || true
sudo systemctl restart labcrasher.service 2>/dev/null || systemctl restart labcrasher.service 2>/dev/null || true
sleep 3
echo "labcrasher.service is now crash-looping. Go find the error in the journal."
