#!/usr/bin/env bash
set -euo pipefail
UNIT=/etc/systemd/system/labdemo.service
if [ ! -f "$UNIT" ]; then
  tmp="$(mktemp)"
  cat > "$tmp" <<'UNITFILE'
[Unit]
Description=Lab demo background service

[Service]
ExecStart=/usr/bin/sleep infinity
Restart=on-failure

[Install]
WantedBy=multi-user.target
UNITFILE
  sudo cp "$tmp" "$UNIT" 2>/dev/null || cp "$tmp" "$UNIT"
  rm -f "$tmp"
  sudo systemctl daemon-reload 2>/dev/null || systemctl daemon-reload 2>/dev/null || true
  sudo systemctl enable --now labdemo 2>/dev/null || systemctl enable --now labdemo 2>/dev/null || true
fi
echo "labdemo.service is present. Add resource limits to its [Service] section."
