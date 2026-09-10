#!/bin/bash
# Verify: a 20% CPU quota is live on kd-lab and real throttling was recorded.
CG=/sys/fs/cgroup/kd-lab
MAX=/tmp/kd-cg/cpu-max.txt
THR=/tmp/kd-cg/cpu-throttle.txt
if [ ! -d "$CG" ] || [ ! -f "$CG/cpu.max" ]; then
  echo "FAIL: kd-lab or its cpu.max is missing — cpu controller not delegated or step 2 skipped"
  exit 1
fi
live=$(tr -s '[:space:]' ' ' < "$CG/cpu.max" | sed 's/ $//')
if [ "$live" != "20000 100000" ]; then
  echo "FAIL: live cpu.max is '$live', expected '20000 100000' (20 ms per 100 ms)"
  exit 1
fi
nr=$(awk '$1=="nr_throttled" {print $2}' "$CG/cpu.stat" 2>/dev/null)
if [ -z "$nr" ] || [ "$nr" -lt 1 ]; then
  echo "FAIL: live cpu.stat shows nr_throttled=$nr — no workload collided with the quota; run the busy loop inside kd-lab"
  exit 1
fi
if [ ! -s "$MAX" ] || [ "$(tr -s '[:space:]' ' ' < "$MAX" | sed 's/ $//')" != "20000 100000" ]; then
  echo "FAIL: cpu-max.txt must record the kernel-reported quota '20000 100000'"
  exit 1
fi
if ! grep -Eq '^nr_throttled [1-9][0-9]*$' "$THR" || ! grep -Eq '^throttled_usec [1-9][0-9]*$' "$THR"; then
  echo "FAIL: cpu-throttle.txt must record nonzero nr_throttled and throttled_usec lines from cpu.stat"
  exit 1
fi
echo "PASS: CPU quota enforced — throttling observed and recorded from cpu.stat"
exit 0
