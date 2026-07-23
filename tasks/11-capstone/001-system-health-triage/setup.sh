#!/usr/bin/env bash
set -euo pipefail
pkill -f lab_capstone_leak >/dev/null 2>&1 || true
sleep 1
nohup bash -c 'exec -a lab_capstone_leak bash -c "while true; do sleep 2; done"' >/dev/null 2>&1 &
disown

rm -rf incident
mkdir -p incident/data
echo "app started ok" > incident/app-output.log
chmod 666 incident/app-output.log

for i in 1 2 3 4; do
  dd if=/dev/zero of="incident/data/part$i.dat" bs=1024 count=5 status=none
done
dd if=/dev/zero of="incident/data/cache_dump.dat" bs=1024 count=8192 status=none

echo "Three issues are now live: runaway process, insecure log file, and an oversized file buried under incident/data/."
