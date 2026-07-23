#!/usr/bin/env bash
set -euo pipefail
if [ ! -f answer.txt ]; then
  echo "answer.txt not found. Write the exact error line into it."
  exit 1
fi
expected="FATAL: missing config at /etc/labcrasher.conf"
got="$(cat answer.txt)"
got_trimmed="$(echo "$got" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')"
if [ "$got_trimmed" = "$expected" ]; then
  echo "Correct — that's the exact fatal error the service logs before crashing."
else
  echo "answer.txt doesn't match the expected error line exactly."
  echo "Expected: $expected"
  echo "Got:      $got_trimmed"
  exit 1
fi
