#!/usr/bin/env bash
set -euo pipefail
rm -rf source dest backup.sh
mkdir -p source/subdir dest
echo "config data" > source/config.yml
echo "nested data" > source/subdir/data.txt
echo "Sample source/ and empty dest/ created. Write backup.sh."
