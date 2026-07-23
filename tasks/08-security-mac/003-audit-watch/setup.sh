#!/usr/bin/env bash
set -euo pipefail
sudo mkdir -p /etc/lab 2>/dev/null || mkdir -p /etc/lab
sudo bash -c 'echo "placeholder=true" > /etc/lab/secrets.conf' 2>/dev/null || echo "placeholder=true" > /etc/lab/secrets.conf
sudo auditctl -W /etc/lab/secrets.conf -k lab-secrets-watch 2>/dev/null | grep -v . || true
echo "/etc/lab/secrets.conf is ready. Set up the audit watch rule for it."
