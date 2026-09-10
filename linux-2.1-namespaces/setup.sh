#!/bin/bash
# Setup for the Linux Namespaces lab. Idempotent: safe to run repeatedly.

# Tools: ip (iproute2), unshare/nsenter (util-linux), findmnt. Usually present;
# install quietly if the image is minimal.
apt-get update -qq > /dev/null 2>&1 || true
apt-get install -y -qq iproute2 util-linux > /dev/null 2>&1 || true

# ip netns needs this directory to register named namespaces.
mkdir -p /run/netns

# Clean any leftovers from a previous run of this lab.
ip netns delete lab-net 2>/dev/null || true
umount /tmp/kd-ns/mnt-demo 2>/dev/null || true
rm -rf /tmp/kd-ns
mkdir -p /tmp/kd-ns
chmod 1777 /tmp/kd-ns

echo "Setup complete."

# Seed /home/ubuntu if it exists (universal-user support).
if [ -d /home/ubuntu ]; then
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
