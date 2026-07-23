#!/usr/bin/env bash
set -euo pipefail
sudo mkdir -p /var/lab/data /var/backups 2>/dev/null || mkdir -p /var/lab/data /var/backups
sudo bash -c 'echo "important data" > /var/lab/data/records.txt' 2>/dev/null || echo "important data" > /var/lab/data/records.txt
sudo rm -f /var/backups/labdata-*.tar.gz 2>/dev/null || rm -f /var/backups/labdata-*.tar.gz 2>/dev/null || true
echo "/var/lab/data is ready with sample data. Build the backup script + timer."
