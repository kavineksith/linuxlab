#!/usr/bin/env bash
set -euo pipefail
tmp1="$(mktemp)"
cat > "$tmp1" <<'BIN'
#!/bin/bash
sleep infinity
BIN
sudo cp "$tmp1" /usr/sbin/labguard 2>/dev/null || cp "$tmp1" /usr/sbin/labguard
rm -f "$tmp1"
sudo chmod +x /usr/sbin/labguard 2>/dev/null || chmod +x /usr/sbin/labguard

tmp2="$(mktemp)"
cat > "$tmp2" <<'PROFILE'
#include <tunables/global>
/usr/sbin/labguard {
  #include <abstractions/base>
  /usr/sbin/labguard mr,
}
PROFILE
sudo cp "$tmp2" /etc/apparmor.d/usr.sbin.labguard 2>/dev/null || cp "$tmp2" /etc/apparmor.d/usr.sbin.labguard
rm -f "$tmp2"

sudo apparmor_parser -r /etc/apparmor.d/usr.sbin.labguard 2>/dev/null || apparmor_parser -r /etc/apparmor.d/usr.sbin.labguard 2>/dev/null || true
sudo aa-complain /usr/sbin/labguard 2>/dev/null || aa-complain /usr/sbin/labguard 2>/dev/null || true
echo "labguard profile loaded in complain mode. Switch it to enforce."
