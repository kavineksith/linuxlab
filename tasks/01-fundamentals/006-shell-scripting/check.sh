#!/usr/bin/env bash
set -euo pipefail
if [ ! -f count_files.sh ]; then
  echo "count_files.sh not found."
  exit 1
fi
if [ ! -x count_files.sh ]; then
  echo "count_files.sh exists but isn't executable. Try: chmod +x count_files.sh"
  exit 1
fi
expected=$(find . -maxdepth 1 -type f ! -name 'count_files.sh' ! -name 'answer.txt' | wc -l)
output="$(./count_files.sh)"
if [ "$output" = "File count: $expected" ]; then
  echo "Script output is correct: $output"
else
  echo "Expected output 'File count: $expected', got '$output'"
  exit 1
fi
