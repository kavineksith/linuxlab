#!/usr/bin/env bash
set -euo pipefail
rm -rf source mirror
mkdir -p source/subdir mirror
echo "keep me" > source/keep.txt
echo "nested keep" > source/subdir/nested.txt
# mirror/ starts out stale: has an old file that no longer exists in source, and is missing a new one
echo "stale leftover" > mirror/stale.txt
echo "Directories ready: source/ is current, mirror/ is stale and needs syncing."
