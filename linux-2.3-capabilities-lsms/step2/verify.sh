#!/bin/bash
# Verify: file capability really attached and really effective for a non-root user.
BIN=/opt/kd-caps/bind88
if [ ! -x "$BIN" ]; then
  echo "FAIL: $BIN missing — compile /opt/kd-caps/test-bind.c first"
  exit 1
fi
if [ ! -s /tmp/kd-caps/bind-before.txt ] || [ ! -s /tmp/kd-caps/getcap.txt ] || [ ! -s /tmp/kd-caps/bind-after.txt ]; then
  echo "FAIL: evidence files missing — record bind-before.txt, getcap.txt and bind-after.txt"
  exit 1
fi
if ! getcap "$BIN" | grep -q 'cap_net_bind_service'; then
  echo "FAIL: live getcap shows no cap_net_bind_service on $BIN — run setcap 'cap_net_bind_service=+ep'"
  exit 1
fi
if ! grep -q 'cap_net_bind_service' /tmp/kd-caps/getcap.txt; then
  echo "FAIL: getcap.txt does not record the attached capability"
  exit 1
fi
if ! grep -q 'bound port 88 OK' /tmp/kd-caps/bind-after.txt; then
  echo "FAIL: bind-after.txt does not show a successful bind — re-run the program as nobody AFTER setcap"
  exit 1
fi
live=$(su -s /bin/bash nobody -c "$BIN" 2>&1)
if ! printf '%s' "$live" | grep -q 'bound port 88 OK'; then
  echo "FAIL: live re-execution as nobody did not bind port 88 (got: $live) — the capability is not effective"
  exit 1
fi
echo "PASS: one narrow power granted via file capability — non-root binds port 88"
exit 0
