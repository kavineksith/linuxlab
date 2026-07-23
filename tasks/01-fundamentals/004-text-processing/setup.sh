#!/usr/bin/env bash
set -euo pipefail
cat > server.conf <<'CONF'
host=0.0.0.0
port=8000
debug=true
workers=4
CONF
echo "Created server.conf with placeholder values."
