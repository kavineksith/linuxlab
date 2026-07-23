#!/usr/bin/env bash
set -euo pipefail
if [ ! -f server.conf ]; then
  echo "server.conf not found — run 'lab start' first."
  exit 1
fi
ok=1
grep -qx 'debug=false' server.conf || { echo "Expected line 'debug=false' not found."; ok=0; }
grep -qx 'port=8443' server.conf || { echo "Expected line 'port=8443' not found."; ok=0; }
grep -qx 'debug=true' server.conf && { echo "Old line 'debug=true' is still present."; ok=0; }
grep -qx 'port=8000' server.conf && { echo "Old line 'port=8000' is still present."; ok=0; }
[ "$ok" -eq 1 ] && echo "server.conf updated correctly."
[ "$ok" -eq 1 ]
