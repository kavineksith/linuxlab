#!/usr/bin/env bash
set -euo pipefail
sudo mkdir -p /var/lab/data 2>/dev/null || mkdir -p /var/lab/data
echo "sample data" | sudo tee /var/lab/data/report.csv >/dev/null 2>&1 || echo "sample data" > /var/lab/data/report.csv
tmp="$(mktemp)"
cat > "$tmp" <<'BIN'
#!/bin/bash
sleep infinity
BIN
sudo cp "$tmp" /usr/local/bin/labreader 2>/dev/null || cp "$tmp" /usr/local/bin/labreader
rm -f "$tmp"
sudo chmod +x /usr/local/bin/labreader 2>/dev/null || chmod +x /usr/local/bin/labreader
echo "/usr/local/bin/labreader is ready. Write and load its AppArmor profile."
