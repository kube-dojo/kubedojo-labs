#!/bin/bash
# Verify: a new PID namespace was created and its isolated process view recorded.
INSIDE=/tmp/kd-ns/pid-inside.txt
COUNT=/tmp/kd-ns/pid-count.txt
if [ ! -s "$INSIDE" ] || [ ! -s "$COUNT" ]; then
  echo "FAIL: evidence files missing — run the unshare command that writes pid-inside.txt and pid-count.txt"
  exit 1
fi
inside=$(head -n1 "$INSIDE" | tr -d '[:space:]')
if ! printf '%s' "$inside" | grep -Eq '^pid:\[[0-9]+\]$'; then
  echo "FAIL: pid-inside.txt does not contain a pid:[...] identity (got: $inside)"
  exit 1
fi
host=$(readlink /proc/self/ns/pid)
if [ "$inside" = "$host" ]; then
  echo "FAIL: recorded identity equals the host PID namespace — the command did not run inside a new PID namespace"
  exit 1
fi
count=$(head -n1 "$COUNT" | tr -d '[:space:]')
if ! printf '%s' "$count" | grep -Eq '^[0-9]+$' || [ "$count" -lt 1 ] || [ "$count" -ge 10 ]; then
  echo "FAIL: pid-count.txt should show a small isolated process count (got: $count) — did you forget --mount-proc?"
  exit 1
fi
echo "PASS: new PID namespace with an isolated process view"
exit 0
