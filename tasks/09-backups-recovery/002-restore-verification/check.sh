#!/usr/bin/env bash
set -euo pipefail
if [ ! -d restored ]; then
  echo "restored/ directory not found — extract db_backup.tar.gz into it first."
  exit 1
fi
missing=0
for f in customers.db transactions.log; do
  [ -f "restored/$f" ] || { echo "restored/$f is missing."; missing=1; }
done
[ "$missing" -eq 0 ] || exit 1

if ( cd restored && sha256sum -c ../db_backup.sha256 >/tmp/verify.log 2>&1 ); then
  echo "All restored files match their checksums — backup verified good."
else
  echo "Checksum verification failed:"
  cat /tmp/verify.log
  exit 1
fi

if [ -f answer.txt ] && grep -qx 'VERIFIED' answer.txt; then
  echo "answer.txt correctly says VERIFIED."
else
  echo "Note: answer.txt should contain exactly 'VERIFIED' once you've confirmed integrity (informational, not blocking)."
fi
