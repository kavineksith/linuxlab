#!/usr/bin/env bash
set -euo pipefail
KEY="$HOME/.ssh/id_ed25519"
PUB="$HOME/.ssh/id_ed25519.pub"
AUTH="$HOME/.ssh/authorized_keys"
ok=1

[ -f "$KEY" ] || { echo "Private key $KEY not found."; ok=0; }
[ -f "$PUB" ] || { echo "Public key $PUB not found."; ok=0; }

if [ -f "$PUB" ]; then
  if ! grep -qF "$(cut -d' ' -f1-2 "$PUB")" "$AUTH" 2>/dev/null; then
    echo "authorized_keys does not contain your public key."
    ok=0
  fi
fi

if [ -d "$HOME/.ssh" ]; then
  sshdir_perm="$(stat -c '%a' "$HOME/.ssh")"
  [ "$sshdir_perm" = "700" ] || { echo "~/.ssh permissions are $sshdir_perm, expected 700."; ok=0; }
fi
if [ -f "$AUTH" ]; then
  auth_perm="$(stat -c '%a' "$AUTH")"
  [ "$auth_perm" = "600" ] || { echo "authorized_keys permissions are $auth_perm, expected 600."; ok=0; }
fi

[ "$ok" -eq 1 ] && echo "SSH key auth is correctly set up."
[ "$ok" -eq 1 ]
