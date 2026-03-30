#!/bin/bash
if [ ! -f /root/affinity-pid.txt ]; then
  echo "FAIL: /root/affinity-pid.txt not found"
  exit 1
fi

PID=$(cat /root/affinity-pid.txt | tr -d '[:space:]')
if ! [[ "$PID" =~ ^[0-9]+$ ]]; then
  echo "FAIL: Invalid PID in file"
  exit 1
fi

# Check that the process has CPU 0 affinity
AFFINITY=$(taskset -p "$PID" 2>/dev/null | awk '{print $NF}')
if [ "$AFFINITY" = "1" ]; then
  echo "PASS: Process $PID is pinned to CPU 0"
  exit 0
else
  echo "FAIL: Process $PID affinity mask is '$AFFINITY', expected '1' (CPU 0)"
  exit 1
fi
