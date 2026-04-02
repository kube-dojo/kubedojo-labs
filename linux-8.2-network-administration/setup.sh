#!/bin/bash
# Setup for network administration lab
apt-get update -qq
apt-get install -y -qq iproute2 iptables > /dev/null 2>&1
# Load dummy module for virtual interfaces
modprobe dummy 2>/dev/null || true
echo "Setup complete."

# Seed /home/ubuntu if it exists
if [ -d /home/ubuntu ]; then
  cp -r /root/* /home/ubuntu/ 2>/dev/null || true
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
