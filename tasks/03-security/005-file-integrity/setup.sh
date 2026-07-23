#!/usr/bin/env bash
set -euo pipefail
rm -rf release
mkdir -p release
echo "binary payload v1" > release/app.bin
echo "documentation contents" > release/README.md
echo "license text" > release/LICENSE
( cd release && sha256sum app.bin README.md LICENSE > checksums.sha256 )
# tamper with one file AFTER checksums were recorded
echo "binary payload v1 -- modified by attacker" > release/README.md
echo "release/ ready with a checksums.sha256 manifest — one file has been altered since."
