#!/usr/bin/env bash
set -euo pipefail
getent group labgroup >/dev/null 2>&1 || sudo groupadd labgroup 2>/dev/null || groupadd labgroup 2>/dev/null || true
echo "TOP SECRET: rotate these credentials" > secrets.txt
chmod 666 secrets.txt
echo "Created secrets.txt with insecure 666 permissions in $(pwd)"
