#!/usr/bin/env bash
set -euo pipefail
rm -rf release release.tar.gz
mkdir -p release/bin release/docs
echo "#!/bin/sh" > release/bin/app.sh
echo "echo hello" >> release/bin/app.sh
echo "Release v1.0 notes" > release/docs/CHANGELOG.md
echo "Created release/ directory with sample build artifacts."
