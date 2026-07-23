#!/usr/bin/env bash
set -euo pipefail
ok=1

if pgrep -f lab_capstone_leak >/dev/null 2>&1; then
  echo "[process]  lab_capstone_leak is STILL running."
  ok=0
else
  echo "[process]  OK — no runaway process."
fi

if [ ! -f incident/app-output.log ]; then
  echo "[permissions] incident/app-output.log is missing entirely."
  ok=0
else
  perms="$(stat -c '%a' incident/app-output.log)"
  owngrp="$(stat -c '%G' incident/app-output.log)"
  mygrp="$(id -gn)"
  if [ "$perms" = "640" ] && [ "$owngrp" = "$mygrp" ]; then
    echo "[permissions] OK — 640, owned by group $mygrp."
  else
    echo "[permissions] app-output.log is $perms, group $owngrp (expected 640, group $mygrp)."
    ok=0
  fi
fi

if [ -d incident/data ]; then
  biggest_size=$(find incident/data -type f -printf '%s\n' | sort -rn | head -n1)
  file_count=$(find incident/data -type f | wc -l)
  if [ -n "$biggest_size" ] && [ "$biggest_size" -gt 1000000 ]; then
    echo "[disk]     An oversized file is still present under incident/data/ (found a ${biggest_size}-byte file)."
    ok=0
  elif [ "$file_count" -lt 4 ]; then
    echo "[disk]     Too few files remain under incident/data/ — did you delete more than just the oversized one?"
    ok=0
  else
    echo "[disk]     OK — oversized file removed, other files intact."
  fi
else
  echo "[disk]     incident/data/ directory is missing entirely."
  ok=0
fi

echo
if [ "$ok" -eq 1 ]; then
  echo "All three issues resolved. Server triaged successfully — nice work."
else
  echo "Not fully resolved yet — see the [process]/[permissions]/[disk] lines above."
fi
[ "$ok" -eq 1 ]
