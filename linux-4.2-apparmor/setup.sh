#!/bin/bash
# Setup script for AppArmor lab

apt-get update -qq
apt-get install -y -qq apparmor apparmor-utils curl > /dev/null 2>&1

# Ensure AppArmor is started
service apparmor start 2>/dev/null || true

# Create apparmor.d directory if missing
mkdir -p /etc/apparmor.d

echo "Setup complete."

# Seed /home/ubuntu if it exists
if [ -d /home/ubuntu ]; then
  cp -r /root/* /home/ubuntu/ 2>/dev/null || true
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
