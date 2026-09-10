#!/bin/bash
# Verify: kd-lab cgroup exists with a live 64 MiB memory.max, and evidence matches.
CG=/sys/fs/cgroup/kd-lab
EV=/tmp/kd-cg/memory-max.txt
if [ ! -d "$CG" ]; then
  echo "FAIL: $CG does not exist — create the cgroup with mkdir"
  exit 1
fi
if [ ! -f "$CG/memory.max" ]; then
  echo "FAIL: $CG/memory.max missing — memory controller not delegated (re-run the lab setup)"
  exit 1
fi
live=$(tr -d '[:space:]' < "$CG/memory.max")
if [ "$live" != "67108864" ]; then
  echo "FAIL: live memory.max is '$live', expected 67108864 (64 MiB) — did you write the limit?"
  exit 1
fi
if [ ! -s "$EV" ] || [ "$(head -n1 "$EV" | tr -d '[:space:]')" != "67108864" ]; then
  echo "FAIL: /tmp/kd-cg/memory-max.txt must record the kernel-reported limit 67108864"
  exit 1
fi
echo "PASS: kd-lab exists with a hard 64 MiB memory ceiling"
exit 0
