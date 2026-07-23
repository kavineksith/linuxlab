#!/usr/bin/env bash
set -euo pipefail
if [ ! -f answer.txt ]; then
  echo "answer.txt not found. Write the path of the largest file into it."
  exit 1
fi
expected="$(find data -type f -printf '%s %p\n' | sort -rn | head -n1 | awk '{print $2}')"
got="$(tr -d '[:space:]' < answer.txt)"
exp_norm="${expected#./}"
got_norm="${got#./}"
if [ "$got_norm" = "$exp_norm" ]; then
  echo "Correct — $expected is the largest file."
else
  echo "answer.txt contains '$got', that's not the largest file. Try: find data -type f -printf '%s %p\n' | sort -rn | head"
  exit 1
fi
