#!/usr/bin/env bash
set -euo pipefail
if ! command -v rsync >/dev/null 2>&1; then
  echo "rsync not installed."
  exit 1
fi
ok=1
[ -f mirror/keep.txt ] || { echo "mirror/keep.txt missing — source files weren't copied."; ok=0; }
[ -f mirror/subdir/nested.txt ] || { echo "mirror/subdir/nested.txt missing — nested files weren't copied."; ok=0; }
[ -f mirror/stale.txt ] && { echo "mirror/stale.txt still exists — a true mirror should have removed files not present in source/ (did you use --delete?)."; ok=0; }
diff -r source mirror >/tmp/diffout 2>&1 || { echo "source/ and mirror/ differ:"; cat /tmp/diffout; ok=0; }
[ "$ok" -eq 1 ] && echo "mirror/ is now an exact mirror of source/."
[ "$ok" -eq 1 ]
