#!/bin/bash
# Verify: baseline PID-namespace identity was saved from the normal host shell.
FILE=/tmp/kd-ns/ns-baseline.txt
if [ ! -s "$FILE" ]; then
  echo "FAIL: $FILE does not exist or is empty"
  exit 1
fi
saved=$(head -n1 "$FILE" | tr -d '[:space:]')
if ! printf '%s' "$saved" | grep -Eq '^pid:\[[0-9]+\]$'; then
  echo "FAIL: $FILE does not contain a pid:[...] namespace identity (got: $saved)"
  exit 1
fi
host=$(readlink /proc/self/ns/pid)
if [ "$saved" != "$host" ]; then
  echo "FAIL: saved identity $saved differs from the host PID namespace $host — record the baseline from your normal shell, not from inside a new namespace"
  exit 1
fi
echo "PASS: baseline PID namespace identity recorded"
exit 0
