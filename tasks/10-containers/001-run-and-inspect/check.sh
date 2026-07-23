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
if ! $ENGINE ps --format '{{.Names}}' 2>/dev/null | grep -qx labweb; then
  echo "No running container named 'labweb' found ($ENGINE ps)."
  exit 1
fi
if ! curl -s --max-time 3 localhost:8081 | grep -qi html; then
  echo "localhost:8081 didn't return HTML — is the port mapping (-p 8081:80) correct?"
  exit 1
fi
echo "labweb is running via $ENGINE and serving on port 8081."
