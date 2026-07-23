#!/usr/bin/env bash
set -euo pipefail
if ! id tempuser >/dev/null 2>&1; then
  sudo useradd -m tempuser 2>/dev/null || useradd -m tempuser 2>/dev/null || \
    echo "Note: could not create 'tempuser' automatically — create it yourself (sudo useradd -m tempuser)."
fi
echo "'tempuser' account is ready. Configure its password aging policy with chage."
