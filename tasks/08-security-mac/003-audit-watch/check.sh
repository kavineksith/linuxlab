#!/usr/bin/env bash
set -euo pipefail
if ! command -v auditctl >/dev/null 2>&1; then
  echo "auditd tools not installed — this task needs a native host with auditd/audit installed."
  exit 1
fi
rules="$(sudo auditctl -l 2>/dev/null || auditctl -l 2>/dev/null || true)"
if ! echo "$rules" | grep -q '/etc/lab/secrets.conf' || ! echo "$rules" | grep -q 'lab-secrets-watch'; then
  echo "No active audit rule found watching /etc/lab/secrets.conf with key lab-secrets-watch."
  echo "Try: sudo auditctl -w /etc/lab/secrets.conf -p wa -k lab-secrets-watch"
  exit 1
fi
echo "test entry" | sudo tee -a /etc/lab/secrets.conf >/dev/null 2>&1 || echo "test entry" >> /etc/lab/secrets.conf
sleep 1
events="$(sudo ausearch -k lab-secrets-watch 2>/dev/null || ausearch -k lab-secrets-watch 2>/dev/null || true)"
if [ -z "$events" ]; then
  echo "auditctl rule exists but no matching events found via ausearch -k lab-secrets-watch."
  exit 1
fi
echo "Audit rule is active and correctly logging writes to /etc/lab/secrets.conf."
