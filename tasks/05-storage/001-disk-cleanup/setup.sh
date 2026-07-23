#!/usr/bin/env bash
set -euo pipefail
rm -rf old_logs
mkdir -p old_logs
for i in 1 2 3 4 5; do
  f="old_logs/app-$i.log"
  echo "old log entry $i" > "$f"
  touch -d "20 days ago" "$f"
done
for i in 1 2 3; do
  f="old_logs/recent-$i.log"
  echo "recent log entry $i" > "$f"
  touch -d "2 days ago" "$f"
done
echo "old_logs/ populated: 5 files older than 14 days, 3 files newer."
