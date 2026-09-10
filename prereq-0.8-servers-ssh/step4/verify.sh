#!/bin/bash
# Verify: work happened through a real second session with a clean disconnect.
L=/var/log/kd-sshd.log
if [ "$(cat /tmp/kd-ssh/hello.txt 2>/dev/null)" != "Hello from SSH!" ]; then
  echo "FAIL: /tmp/kd-ssh/hello.txt must contain exactly 'Hello from SSH!' written through the session"
  exit 1
fi
acc=$(grep -c "Accepted publickey for $USER" "$L" 2>/dev/null)
disc=$(grep -c "Disconnected from user $USER" "$L" 2>/dev/null)
if [ "${acc:-0}" -lt 2 ]; then
  echo "FAIL: server log shows $acc key login(s) — this step needs a second real session"
  exit 1
fi
if [ "${disc:-0}" -lt 2 ]; then
  echo "FAIL: server log shows $disc clean disconnect(s) — end the session with exit"
  exit 1
fi
if [ "$(cat /tmp/kd-ssh/after-exit.txt 2>/dev/null)" != "$(hostname)" ]; then
  echo "FAIL: /tmp/kd-ssh/after-exit.txt must record the live hostname after you return"
  exit 1
fi
echo "PASS: full lifecycle — connected, worked, disconnected cleanly, back at the local shell"
exit 0
