#!/usr/bin/env bash
set -euo pipefail
rm -rf data
mkdir -p data/level1/level2/level3 data/archive data/tmp
echo "dev settings" > data/config.dev.yml
echo "staging settings" > data/level1/config.staging.yml
echo "old settings" > data/archive/config.prod.yml.bak
echo "PRODUCTION SETTINGS - do not lose this" > data/level1/level2/config.prod.yml
echo "scratch" > data/tmp/notes.txt
echo "Directory tree created under ./data — go find the real config."
