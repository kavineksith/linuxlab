#!/usr/bin/env bash
set -euo pipefail
ok=1

if ! id devuser >/dev/null 2>&1; then
  echo "User 'devuser' does not exist. Try: sudo useradd -m devuser"
  ok=0
else
  if ! getent passwd devuser | cut -d: -f6 | grep -q '^/home/devuser$'; then
    echo "devuser exists but has no proper home directory (/home/devuser)."
    ok=0
  fi
fi

if ! getent group developers >/dev/null 2>&1; then
  echo "Group 'developers' does not exist. Try: sudo groupadd developers"
  ok=0
fi

if id devuser >/dev/null 2>&1; then
  if ! id -nG devuser | tr ' ' '\n' | grep -qx sudo; then
    echo "devuser is not in the 'sudo' group. Try: sudo usermod -aG sudo devuser"
    ok=0
  fi
  if ! id -nG devuser | tr ' ' '\n' | grep -qx developers; then
    echo "devuser is not in the 'developers' group. Try: sudo usermod -aG developers devuser"
    ok=0
  fi
fi

[ "$ok" -eq 1 ] && echo "devuser is fully onboarded."
[ "$ok" -eq 1 ]
