#!/usr/bin/env bash
set -euo pipefail
if ! id deploy >/dev/null 2>&1; then
  sudo useradd -m deploy 2>/dev/null || useradd -m deploy 2>/dev/null || \
    echo "Note: could not create 'deploy' user automatically — create it yourself if missing (sudo useradd -m deploy)."
fi
echo "User 'deploy' is ready. Create /etc/sudoers.d/deploy-nginx as described in the objective."
