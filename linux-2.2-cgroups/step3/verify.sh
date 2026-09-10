#!/bin/bash
# Verify: a process ran inside kd-lab and recorded real charged memory.
INNER=/tmp/kd-cg/inner-path.txt
CUR=/tmp/kd-cg/memory-current.txt
if [ ! -d /sys/fs/cgroup/kd-lab ]; then
  echo "FAIL: /sys/fs/cgroup/kd-lab is gone — re-run step 2"
  exit 1
fi
if [ ! -s "$INNER" ] || [ ! -s "$CUR" ]; then
  echo "FAIL: evidence files missing — run the in-cgroup shell that writes inner-path.txt and memory-current.txt"
  exit 1
fi
if ! grep -Eq '^0::.*kd-lab/?$' "$INNER"; then
  echo "FAIL: inner-path.txt does not show kd-lab membership — the recording process was not inside the cgroup"
  exit 1
fi
cur=$(head -n1 "$CUR" | tr -d '[:space:]')
if ! printf '%s' "$cur" | grep -Eq '^[0-9]+$'; then
  echo "FAIL: memory-current.txt is not a byte count (got: $cur)"
  exit 1
fi
if [ "$cur" -lt 8388608 ] || [ "$cur" -gt 67108864 ]; then
  echo "FAIL: recorded memory.current ($cur) should be >= 8 MiB (allocation held) and <= the 64 MiB limit"
  exit 1
fi
echo "PASS: memory was charged to kd-lab and read from the kernel's accounting"
exit 0
