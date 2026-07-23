#!/usr/bin/env bash
set -euo pipefail
result="$(getent hosts lab.internal 2>/dev/null || true)"
if echo "$result" | grep -qE '^127\.0\.0\.1\s'; then
  echo "lab.internal correctly resolves to 127.0.0.1"
else
  echo "lab.internal does not resolve to 127.0.0.1 yet. Add a line to /etc/hosts."
  exit 1
fi
