#!/usr/bin/env bash
set -euo pipefail
rm -rf subdir count_files.sh
mkdir -p subdir
for i in 1 2 3 4 5; do echo "file $i" > "note$i.txt"; done
echo "extra content" > readme.md
# these two live inside subdir/ and must NOT be counted
echo "nested" > subdir/inner1.txt
echo "nested" > subdir/inner2.txt
echo "Workspace seeded with files. Now write count_files.sh."
