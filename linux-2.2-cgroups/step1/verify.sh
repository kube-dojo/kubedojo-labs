#!/bin/bash
# Verify: cgroup v2 identified and own membership recorded.
VER=/tmp/kd-cg/version.txt
SELF=/tmp/kd-cg/self-path.txt
if [ ! -s "$VER" ] || [ ! -s "$SELF" ]; then
  echo "FAIL: evidence files missing — write version.txt and self-path.txt in /tmp/kd-cg/"
  exit 1
fi
recorded=$(head -n1 "$VER" | tr -d '[:space:]')
live=$(stat -fc %T /sys/fs/cgroup)
if [ "$recorded" != "cgroup2fs" ]; then
  echo "FAIL: version.txt must contain cgroup2fs (got: $recorded)"
  exit 1
fi
if [ "$live" != "cgroup2fs" ]; then
  echo "FAIL: live /sys/fs/cgroup is $live, not cgroup2fs — recorded evidence does not match this host"
  exit 1
fi
if ! grep -Eq '^0::/' "$SELF"; then
  echo "FAIL: self-path.txt has no v2 membership line (expected a line starting with 0::/) — record /proc/self/cgroup"
  exit 1
fi
echo "PASS: cgroup v2 confirmed and own membership recorded"
exit 0
