#!/usr/bin/env bash
set -euo pipefail
if [ ! -f answer.txt ]; then
  echo "answer.txt not found. Write the path you found into it."
  exit 1
fi
expected="$(find . -name 'config.prod.yml' -not -path '*/archive/*' | head -n1)"
got="$(tr -d '[:space:]' < answer.txt)"
# accept with or without leading ./
exp_norm="${expected#./}"
got_norm="${got#./}"
if [ "$got_norm" = "$exp_norm" ]; then
  echo "Correct — found it at $expected"
else
  echo "answer.txt contains '$got', expected the path to the real config.prod.yml (not the .bak decoy)."
  exit 1
fi
