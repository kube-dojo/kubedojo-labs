#!/bin/bash
# Verify: matching Ed25519 pair, authorized, correct permissions, lab sshd live.
K="$HOME/.ssh/kd-lab-key"
if [ ! -f "$K" ] || [ ! -f "$K.pub" ]; then
  echo "FAIL: key pair not found at ~/.ssh/kd-lab-key — run ssh-keygen"
  exit 1
fi
if [ "$(stat -c %a "$K")" != "600" ]; then
  echo "FAIL: private key must be mode 600 (found $(stat -c %a "$K"))"
  exit 1
fi
pub=$(awk '{print $1" "$2}' "$K.pub")
derived=$(ssh-keygen -y -f "$K" 2>/dev/null | awk '{print $1" "$2}')
if [ -z "$derived" ] || [ "$pub" != "$derived" ]; then
  echo "FAIL: kd-lab-key.pub does not match the private key — regenerate the pair"
  exit 1
fi
if ! grep -qF "$(awk '{print $2}' "$K.pub")" "$HOME/.ssh/authorized_keys" 2>/dev/null; then
  echo "FAIL: public key not in ~/.ssh/authorized_keys — the server has no lock to check"
  exit 1
fi
if [ "$(stat -c %a "$HOME/.ssh/authorized_keys")" != "600" ] || [ "$(stat -c %a "$HOME/.ssh")" != "700" ]; then
  echo "FAIL: permissions must be 700 on ~/.ssh and 600 on authorized_keys"
  exit 1
fi
if ! timeout 3 bash -c 'exec 3<>/dev/tcp/127.0.0.1/2222' 2>/dev/null; then
  echo "FAIL: no SSH server listening on port 2222 — re-run the setup script"
  exit 1
fi
echo "PASS: key pair generated and authorized — the server holds the lock, you hold the key"
exit 0
