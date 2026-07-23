#!/usr/bin/env bash
set -euo pipefail
if [ ! -f secrets.txt ]; then
  echo "secrets.txt not found — run 'lab start' first."
  exit 1
fi
perms="$(stat -c '%a' secrets.txt)"
group="$(stat -c '%G' secrets.txt)"
ok=1
if [ "$perms" != "640" ]; then
  echo "Permissions are $perms, expected 640. Try: chmod 640 secrets.txt"
  ok=0
fi
if [ "$group" != "labgroup" ]; then
  echo "Group owner is '$group', expected 'labgroup'. Try: chgrp labgroup secrets.txt"
  ok=0
fi
[ "$ok" -eq 1 ]
