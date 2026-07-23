#!/usr/bin/env bash
set -euo pipefail
if ! command -v ip >/dev/null 2>&1; then
  echo "'ip' command not found (iproute2 not installed)."
  exit 1
fi
if ip -4 addr show 2>/dev/null | grep -q '192.168.77.10/24'; then
  echo "192.168.77.10/24 is present."
else
  echo "192.168.77.10/24 not found on any interface. Did you run 'sudo ip addr add 192.168.77.10/24 dev lo'?"
  echo "(If this fails with 'Operation not permitted', this environment lacks NET_ADMIN — try a native host.)"
  exit 1
fi
