#!/usr/bin/env bash
set -euo pipefail
if [ ! -f release.tar.gz ]; then
  echo "release.tar.gz not found in the workspace root."
  exit 1
fi
if ! file release.tar.gz 2>/dev/null | grep -qi gzip && ! gzip -t release.tar.gz 2>/dev/null; then
  echo "release.tar.gz doesn't look like a valid gzip archive."
  exit 1
fi
missing=0
for f in release/bin/app.sh release/docs/CHANGELOG.md; do
  tar -tzf release.tar.gz | grep -q "$f" || { echo "Archive is missing $f"; missing=1; }
done
[ "$missing" -eq 0 ] && echo "release.tar.gz contains the expected files."
[ "$missing" -eq 0 ]
