#!/usr/bin/env bash
set -euo pipefail
ENGINE=""
if command -v docker >/dev/null 2>&1 && docker info >/dev/null 2>&1; then
  ENGINE=docker
elif command -v podman >/dev/null 2>&1; then
  ENGINE=podman
fi
if [ -z "$ENGINE" ]; then
  echo "Neither a working docker nor podman installation was found on this host."
  exit 1
fi

$ENGINE network inspect labnet >/dev/null 2>&1 || { echo "Network 'labnet' not found."; exit 1; }
$ENGINE ps --format '{{.Names}}' 2>/dev/null | grep -qx labdb || { echo "Container 'labdb' is not running."; exit 1; }
$ENGINE ps --format '{{.Names}}' 2>/dev/null | grep -qx labapi || { echo "Container 'labapi' is not running."; exit 1; }

for c in labdb labapi; do
  net="$($ENGINE inspect "$c" --format '{{range $k,$v := .NetworkSettings.Networks}}{{$k}} {{end}}' 2>/dev/null || true)"
  echo "$net" | grep -qw labnet || { echo "$c is not attached to labnet (attached to: $net)."; exit 1; }
done

if $ENGINE exec labapi ping -c 1 -W 2 labdb >/tmp/ping.log 2>&1; then
  echo "labapi successfully reached labdb by name over labnet."
else
  echo "labapi could not ping labdb by name:"
  cat /tmp/ping.log
  exit 1
fi
