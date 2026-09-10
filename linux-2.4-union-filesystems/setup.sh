#!/bin/bash
# Setup for the Union Filesystems lab. Idempotent: safe to run repeatedly (doubles as reset).

# Unwind any previous run: merged overlay first, then the backing tmpfs.
umount /tmp/kd-ufs/merged 2>/dev/null || true
umount /tmp/kd-ufs 2>/dev/null || true
rm -rf /tmp/kd-ufs
mkdir -p /tmp/kd-ufs

# Deterministic backing filesystem: overlay's upperdir/workdir cannot live on
# another overlayfs (e.g. a container root), and host /tmp mount flags vary.
# A small dedicated tmpfs behaves identically on every target host.
mount -t tmpfs -o size=64m kd-ufs /tmp/kd-ufs 2>/dev/null || \
  echo "WARNING: could not mount tmpfs at /tmp/kd-ufs — overlay mounts may fail in this environment."
chmod 1777 /tmp/kd-ufs

mkdir -p /tmp/kd-ufs/evidence
chmod 1777 /tmp/kd-ufs/evidence

echo "Setup complete."

# Seed /home/ubuntu if it exists (universal-user support).
if [ -d /home/ubuntu ]; then
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
