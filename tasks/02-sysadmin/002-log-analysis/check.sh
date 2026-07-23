#!/usr/bin/env bash
set -euo pipefail
if [ ! -f auth.log ]; then
  echo "auth.log not found — run 'lab start' first."
  exit 1
fi
if [ ! -f answer.txt ]; then
  echo "answer.txt not found. Write the offending IP into a file called answer.txt."
  exit 1
fi

expected="$(grep 'Failed password' auth.log | grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}' | sort | uniq -c | sort -rn | head -n1 | awk '{print $2}')"
got="$(tr -d '[:space:]' < answer.txt)"

if [ "$got" = "$expected" ]; then
  echo "Correct — $expected is the brute-force source."
else
  echo "answer.txt contains '$got', that's not the top offender. Keep digging with grep/awk/sort/uniq -c."
  exit 1
fi
