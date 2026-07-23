#!/usr/bin/env bash
set -euo pipefail
FILE=/etc/sudoers.d/deploy-nginx
if [ ! -f "$FILE" ]; then
  echo "$FILE does not exist. Create it (as root) with the required rule."
  exit 1
fi

if ! visudo -cf "$FILE" >/dev/null 2>&1; then
  echo "$FILE has a syntax error. Run: sudo visudo -cf $FILE"
  exit 1
fi

content="$(cat "$FILE")"
if echo "$content" | grep -qE '^deploy[[:space:]]+ALL=\(ALL\)[[:space:]]+NOPASSWD:[[:space:]]*/usr/bin/systemctl restart nginx[[:space:]]*$' || \
   echo "$content" | grep -qE '^deploy[[:space:]]+ALL=\(ALL\)[[:space:]]+NOPASSWD:[[:space:]]*/bin/systemctl restart nginx[[:space:]]*$'; then
  :
else
  echo "Rule not found or too broad. It must restrict deploy to exactly the nginx restart command, e.g.:"
  echo "  deploy ALL=(ALL) NOPASSWD: /usr/bin/systemctl restart nginx"
  exit 1
fi

if echo "$content" | grep -qE 'ALL=\(ALL\)[[:space:]]+NOPASSWD:[[:space:]]*ALL'; then
  echo "This rule grants unrestricted sudo (NOPASSWD: ALL) — that's too broad. Restrict it to the nginx restart command only."
  exit 1
fi

echo "Sudoers rule is correctly scoped to the nginx restart command."
