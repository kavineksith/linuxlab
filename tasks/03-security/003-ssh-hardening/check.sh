#!/usr/bin/env bash
set -euo pipefail
FILE=/etc/ssh/sshd_config
if [ ! -f "$FILE" ]; then
  echo "$FILE not found — this task needs openssh-server installed on a native host."
  exit 1
fi
ok=1
grep -qiE '^\s*PermitRootLogin\s+no\s*$' "$FILE" || { echo "PermitRootLogin no not set (check for commented-out or conflicting lines)."; ok=0; }
grep -qiE '^\s*PasswordAuthentication\s+no\s*$' "$FILE" || { echo "PasswordAuthentication no not set."; ok=0; }
if command -v sshd >/dev/null 2>&1; then
  if ! sudo sshd -t 2>/tmp/sshd_test_err && ! sshd -t 2>/tmp/sshd_test_err; then
    echo "sshd -t reports a syntax error in the config:"
    cat /tmp/sshd_test_err
    ok=0
  fi
fi
[ "$ok" -eq 1 ] && echo "sshd_config is hardened and syntactically valid."
[ "$ok" -eq 1 ]
