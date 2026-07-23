#!/usr/bin/env bash
set -euo pipefail
tmp1="$(mktemp)"
cat > "$tmp1" <<'SCRIPT'
#!/usr/bin/env bash
while true; do sleep 3600; done
SCRIPT
sudo cp "$tmp1" /usr/local/bin/webapp-server.sh 2>/dev/null || cp "$tmp1" /usr/local/bin/webapp-server.sh
rm -f "$tmp1"
sudo chmod +x /usr/local/bin/webapp-server.sh 2>/dev/null || chmod +x /usr/local/bin/webapp-server.sh

tmp2="$(mktemp)"
cat > "$tmp2" <<'UNIT'
[Unit]
Description=Lab web application

[Service]
ExecStart=/usr/local/bin/webapp-serverr.sh
Restart=on-failure

[Install]
WantedBy=multi-user.target
UNIT
sudo cp "$tmp2" /etc/systemd/system/webapp.service 2>/dev/null || cp "$tmp2" /etc/systemd/system/webapp.service
rm -f "$tmp2"

sudo systemctl daemon-reload 2>/dev/null || systemctl daemon-reload 2>/dev/null || true
sudo systemctl start webapp.service 2>/dev/null || systemctl start webapp.service 2>/dev/null || true
echo "webapp.service deployed with a typo'd ExecStart path — it will fail to start. Go diagnose it."
