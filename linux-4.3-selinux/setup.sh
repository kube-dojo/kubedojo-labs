#!/bin/bash
# Setup script for SELinux lab
# Note: Full SELinux enforcement requires a SELinux-enabled kernel.
# On Ubuntu/Killercoda we install userspace tools for exploration.

apt-get update -qq
apt-get install -y -qq policycoreutils selinux-utils > /dev/null 2>&1

# Create working directory
for home in /root /home/ubuntu; do
  [ -d "$home" ] || continue
  mkdir -p "$home/selinux-lab"
done

echo "Setup complete."
echo "Note: SELinux userspace tools installed. Full enforcement may not be available on this kernel."


if [ -d /home/ubuntu ]; then
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
