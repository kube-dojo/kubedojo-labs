#!/bin/bash
# Setup for the Control Groups lab. Idempotent: safe to run repeatedly (doubles as reset).

# This lab targets the cgroup v2 unified hierarchy, matching the module's node baseline.
if [ "$(stat -fc %T /sys/fs/cgroup 2>/dev/null)" != "cgroup2fs" ]; then
  echo "WARNING: /sys/fs/cgroup is not cgroup2fs — this lab expects a cgroup v2 host."
fi

# Clean leftovers from a previous run: evict lab cgroup members, then remove the group.
# Snapshot the pid list first — reading cgroup.procs while members leave skips entries.
if [ -d /sys/fs/cgroup/kd-lab ]; then
  for pid in $(cat /sys/fs/cgroup/kd-lab/cgroup.procs 2>/dev/null); do
    kill -9 "$pid" 2>/dev/null || true
  done
  sleep 0.3
  rmdir /sys/fs/cgroup/kd-lab 2>/dev/null || true
fi
rm -rf /tmp/kd-cg
mkdir -p /tmp/kd-cg
chmod 1777 /tmp/kd-cg

# Children of the cgroup root need the cpu and memory controllers delegated.
# On a systemd host the root cgroup holds no processes, so the write succeeds directly.
# Inside a bare container the initial shell sits in the (namespace) root cgroup, which
# blocks delegation ("no internal processes" rule) — park those processes in a leaf first.
want=""
for c in cpu memory; do
  grep -qw "$c" /sys/fs/cgroup/cgroup.subtree_control || want="$want +$c"
done
if [ -n "$want" ]; then
  if ! echo $want > /sys/fs/cgroup/cgroup.subtree_control 2>/dev/null; then
    mkdir -p /sys/fs/cgroup/kd-init
    # Snapshot-then-move, twice: reading cgroup.procs while moving its members
    # skips entries (seq_file position shifts), which would leave a process in
    # the root cgroup and keep the delegation write failing with EBUSY.
    for attempt in 1 2; do
      for pid in $(cat /sys/fs/cgroup/cgroup.procs 2>/dev/null); do
        echo "$pid" > /sys/fs/cgroup/kd-init/cgroup.procs 2>/dev/null || true
      done
      echo $want > /sys/fs/cgroup/cgroup.subtree_control 2>/dev/null && break
    done
  fi
fi

echo "Setup complete."

# Seed /home/ubuntu if it exists (universal-user support).
if [ -d /home/ubuntu ]; then
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
