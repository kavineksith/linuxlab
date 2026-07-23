#!/usr/bin/env bash
set -euo pipefail
rm -rf data
mkdir -p data/cache data/uploads/2024 data/logs
dd if=/dev/zero of=data/cache/thumbnail.tmp bs=1024 count=10 status=none
dd if=/dev/zero of=data/logs/app.log bs=1024 count=50 status=none
dd if=/dev/zero of=data/uploads/2024/report.pdf bs=1024 count=30 status=none
dd if=/dev/zero of=data/uploads/2024/dump.sql bs=1024 count=4096 status=none
echo "Sample files created under ./data — one is much bigger than the rest."
