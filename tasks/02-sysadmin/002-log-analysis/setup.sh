#!/usr/bin/env bash
set -euo pipefail
ATTACKER="198.51.100.77"
gen_line() {
  local ip="$1" ok="$2"
  local ts="Jul 20 10:$(printf '%02d' $((RANDOM % 60))):$(printf '%02d' $((RANDOM % 60)))"
  if [ "$ok" = "fail" ]; then
    echo "$ts labhost sshd[1234]: Failed password for root from $ip port 5$(printf '%04d' $((RANDOM % 9999))) ssh2"
  else
    echo "$ts labhost sshd[1234]: Accepted password for labuser from $ip port 5$(printf '%04d' $((RANDOM % 9999))) ssh2"
  fi
}

: > auth.log
# noise: a handful of normal IPs with a few failed/accepted attempts each
for ip in 203.0.113.10 203.0.113.11 203.0.113.12 203.0.113.13 203.0.113.14; do
  for i in $(seq 1 3); do gen_line "$ip" fail >> auth.log; done
  gen_line "$ip" ok >> auth.log
done
# the attacker: many more failed attempts than anyone else
for i in $(seq 1 40); do gen_line "$ATTACKER" fail >> auth.log; done

shuf auth.log -o auth.log 2>/dev/null || true
echo "Generated auth.log with $(wc -l < auth.log) lines in $(pwd)"
