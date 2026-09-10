#!/bin/bash
# Verify: real first connection — known_hosts matches the LIVE host key,
# the server log shows a real key login, remote context matches the machine.
F=/tmp/kd-ssh/remote-context.txt
entry=$(ssh-keygen -F '[localhost]:2222' -f "$HOME/.ssh/known_hosts" 2>/dev/null | grep -v '^#' | head -1)
if [ -z "$entry" ]; then
  echo "FAIL: no [localhost]:2222 entry in ~/.ssh/known_hosts — no first-contact trust happened"
  exit 1
fi
blob=$(printf '%s\n' "$entry" | awk '{print $3}')
if ! awk '{print $2}' /etc/ssh/ssh_host_*_key.pub 2>/dev/null | grep -qxF "$blob"; then
  echo "FAIL: known_hosts entry does not match this server's real host key — forged entry?"
  exit 1
fi
if ! grep -q "Accepted publickey for $USER" /var/log/kd-sshd.log 2>/dev/null; then
  echo "FAIL: server log has no 'Accepted publickey for $USER' — no real key login happened"
  exit 1
fi
if [ ! -s "$F" ] || [ "$(wc -l < "$F")" -ne 3 ]; then
  echo "FAIL: $F must hold 3 lines captured inside the session: hostname, whoami, pwd"
  exit 1
fi
if [ "$(sed -n 1p "$F")" != "$(hostname)" ] || [ "$(sed -n 2p "$F")" != "$USER" ]; then
  echo "FAIL: remote context does not match the live machine and account"
  exit 1
fi
echo "PASS: first connection made — host trusted deliberately, key login logged by the server"
exit 0
