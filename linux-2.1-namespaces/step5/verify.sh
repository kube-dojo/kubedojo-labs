#!/bin/bash
# Verify: tmpfs was mounted inside a mount namespace (evidence captured there),
# while the host sees neither the mount nor the file written through it.
EVIDENCE=/tmp/kd-ns/mnt-evidence.txt
if [ ! -s "$EVIDENCE" ]; then
  echo "FAIL: $EVIDENCE missing — capture findmnt output from inside the mount namespace"
  exit 1
fi
if ! grep -q '/tmp/kd-ns/mnt-demo' "$EVIDENCE" || ! grep -q 'tmpfs' "$EVIDENCE"; then
  echo "FAIL: evidence does not show a tmpfs mounted on /tmp/kd-ns/mnt-demo"
  exit 1
fi
if findmnt --mountpoint /tmp/kd-ns/mnt-demo > /dev/null 2>&1; then
  echo "FAIL: the host mount table still shows /tmp/kd-ns/mnt-demo — the mount was made in the host namespace, not inside 'unshare --mount'"
  exit 1
fi
if [ -e /tmp/kd-ns/mnt-demo/data.txt ]; then
  echo "FAIL: data.txt is visible on the host — it was not written through the namespace's tmpfs"
  exit 1
fi
if [ ! -d /tmp/kd-ns/mnt-demo ]; then
  echo "FAIL: /tmp/kd-ns/mnt-demo directory missing — the underlying directory should survive on the host"
  exit 1
fi
echo "PASS: mount and file were namespace-private; only the directory and evidence survive"
exit 0
