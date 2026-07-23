#!/usr/bin/env bash
set -euo pipefail
if [ ! -f answer.txt ]; then
  echo "answer.txt not found. Write the name of the tampered file into it."
  exit 1
fi
if [ ! -d release ]; then
  echo "release/ directory not found — run 'lab start' first."
  exit 1
fi
expected="$(cd release && { sha256sum -c checksums.sha256 2>/dev/null || true; } | grep -v ': OK' | head -n1 | cut -d: -f1)"
got="$(tr -d '[:space:]' < answer.txt)"
if [ -z "$expected" ]; then
  echo "Checker couldn't reproduce a failure — has release/ been modified back? Re-run 'lab start' if needed."
  exit 1
fi
if [ "$got" = "$expected" ]; then
  echo "Correct — $expected fails checksum verification."
else
  echo "answer.txt contains '$got', expected '$expected'. Try: cd release && sha256sum -c checksums.sha256"
  exit 1
fi
