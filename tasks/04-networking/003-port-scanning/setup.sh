#!/usr/bin/env bash
set -euo pipefail
pkill -f 'http.server.*9[0-9][0-9][0-9]' >/dev/null 2>&1 || true
sleep 1
PORT=$(( (RANDOM % 100) + 9000 ))
if command -v python3 >/dev/null 2>&1; then
  nohup python3 -m http.server "$PORT" --bind 127.0.0.1 >/tmp/lab_port_listener.log 2>&1 &
  disown
elif command -v nc >/dev/null 2>&1; then
  nohup bash -c "while true; do echo -e 'HTTP/1.1 200 OK\r\n\r\nok' | nc -l -p $PORT 127.0.0.1; done" >/tmp/lab_port_listener.log 2>&1 &
  disown
else
  echo "Neither python3 nor nc is available to start a listener — install one of them." >&2
  exit 1
fi
sleep 1
echo "A process is now listening on a port between 9000 and 9100. Go find it."
