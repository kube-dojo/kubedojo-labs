#!/bin/bash
# Verify: a real OOM kill happened inside kd-lab and its evidence was recorded.
EXIT=/tmp/kd-cg/oom-exit.txt
EVENTS=/tmp/kd-cg/oom-events.txt
CG=/sys/fs/cgroup/kd-lab
if [ ! -d "$CG" ]; then
  echo "FAIL: $CG is gone — re-run step 2"
  exit 1
fi
if [ ! -s "$EXIT" ] || [ ! -s "$EVENTS" ]; then
  echo "FAIL: evidence files missing — record oom-exit.txt and oom-events.txt"
  exit 1
fi
code=$(head -n1 "$EXIT" | tr -d '[:space:]')
if [ "$code" != "137" ]; then
  echo "FAIL: recorded exit code is '$code', expected 137 (128 + SIGKILL) — did the hog really get OOM-killed?"
  exit 1
fi
live=$(awk '$1=="oom_kill" {print $2}' "$CG/memory.events" 2>/dev/null)
if [ -z "$live" ] || [ "$live" -lt 1 ]; then
  echo "FAIL: live memory.events shows no oom_kill in kd-lab — the kernel never enforced the limit here"
  exit 1
fi
if ! grep -Eq '^oom_kill [1-9][0-9]*$' "$EVENTS"; then
  echo "FAIL: oom-events.txt must record the oom_kill counter line from memory.events"
  exit 1
fi
echo "PASS: hard memory enforcement proven — SIGKILL exit 137 and oom_kill counter incremented"
exit 0
