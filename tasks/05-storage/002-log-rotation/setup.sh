#!/usr/bin/env bash
set -euo pipefail
sudo mkdir -p /var/log 2>/dev/null || mkdir -p /var/log
sudo touch /var/log/labapp.log 2>/dev/null || touch /var/log/labapp.log
echo "/var/log/labapp.log exists and is growing unchecked. Configure rotation for it."
