#!/usr/bin/env bash
set -euo pipefail
if [ ! -f backup.sh ]; then
  echo "backup.sh not found."
  exit 1
fi
if [ ! -x backup.sh ]; then
  echo "backup.sh exists but isn't executable. Try: chmod +x backup.sh"
  exit 1
fi
if [ ! -d source ] || [ ! -d dest ]; then
  echo "source/ or dest/ directory missing — run 'lab start' again."
  exit 1
fi
before=$(ls dest/backup-*.tar.gz 2>/dev/null | wc -l)
./backup.sh source dest
after=$(ls dest/backup-*.tar.gz 2>/dev/null | wc -l)
if [ "$after" -le "$before" ]; then
  echo "No new backup-*.tar.gz file appeared in dest/ after running ./backup.sh source dest"
  exit 1
fi
archive="$(ls -t dest/backup-*.tar.gz | head -n1)"
missing=0
for f in config.yml subdir/data.txt; do
  tar -tzf "$archive" | grep -q "$f" || { echo "Archive $archive is missing $f"; missing=1; }
done
[ "$missing" -eq 0 ] && echo "backup.sh produced a correct archive: $archive"
[ "$missing" -eq 0 ]
