#!/usr/bin/env bash
set -euo pipefail
ENGINE=""
if command -v docker >/dev/null 2>&1 && docker info >/dev/null 2>&1; then
  ENGINE=docker
elif command -v podman >/dev/null 2>&1; then
  ENGINE=podman
fi
if [ -z "$ENGINE" ]; then
  echo "Neither a working docker nor podman installation was found on this host."
  exit 1
fi
[ -f Dockerfile ] || { echo "Dockerfile not found in workspace."; exit 1; }
[ -f greet.sh ] || { echo "greet.sh not found in workspace."; exit 1; }

$ENGINE build -t labapp:1.0 . >/tmp/build.log 2>&1 || { echo "Build failed:"; tail -20 /tmp/build.log; exit 1; }

if ! $ENGINE images --format '{{.Repository}}:{{.Tag}}' 2>/dev/null | grep -qx 'labapp:1.0'; then
  echo "Image labapp:1.0 was not found after build."
  exit 1
fi

output="$($ENGINE run --rm labapp:1.0 2>/dev/null || true)"
if [ -z "$output" ]; then
  echo "Running the container produced no output — does greet.sh print something?"
  exit 1
fi
echo "labapp:1.0 built and runs correctly, output: $output"
