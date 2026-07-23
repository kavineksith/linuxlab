#!/usr/bin/env bash
set -euo pipefail
mkdir -p "$HOME/.ssh"
rm -f "$HOME/.ssh/id_ed25519" "$HOME/.ssh/id_ed25519.pub"
echo "Workspace ready. Generate your keypair into ~/.ssh/id_ed25519."
