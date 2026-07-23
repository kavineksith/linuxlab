#!/usr/bin/env bash
set -euo pipefail
if [ ! -f answer.txt ]; then
  echo "answer.txt not found. Write the port number into it."
  exit 1
fi
find_port() {
  if command -v ss >/dev/null 2>&1; then
    ss -ltn 2>/dev/null | awk '{print $4}' | grep -oE '[0-9]+$' | awk '$1>=9000 && $1<=9100' | head -n1
  elif command -v netstat >/dev/null 2>&1; then
    netstat -ltn 2>/dev/null | awk '{print $4}' | grep -oE '[0-9]+$' | awk '$1>=9000 && $1<=9100' | head -n1
  fi
}
expected="$(find_port)"
got="$(tr -d '[:space:]' < answer.txt)"
if [ -z "$expected" ]; then
  echo "No listener found in the 9000-9100 range right now — try 'lab start' again to relaunch it."
  exit 1
fi
if [ "$got" = "$expected" ]; then
  echo "Correct — port $expected has the listener."
else
  echo "answer.txt contains '$got', expected '$expected'. Try: ss -ltn"
  exit 1
fi
