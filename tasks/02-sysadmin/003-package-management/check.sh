#!/usr/bin/env bash
set -euo pipefail
if ! command -v tree >/dev/null 2>&1; then
  echo "'tree' command not found. Install it with apt."
  exit 1
fi
if ! dpkg -s tree >/dev/null 2>&1; then
  echo "'tree' binary found but dpkg doesn't show it as a managed package — install via apt, not a manual copy."
  exit 1
fi
echo "tree is installed: $(tree --version | head -n1)"
