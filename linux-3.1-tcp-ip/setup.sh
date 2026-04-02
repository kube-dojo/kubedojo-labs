#!/bin/bash
# Setup script for TCP/IP Networking Fundamentals lab

# Install nginx for step 3
apt-get update -qq
apt-get install -y -qq nginx curl iproute2 > /dev/null 2>&1

# Ensure nginx is stopped initially (step 3 will start it)
systemctl stop nginx 2>/dev/null || true
pkill nginx 2>/dev/null || true

echo "Setup complete."

# Seed /home/ubuntu if it exists
if [ -d /home/ubuntu ]; then
  cp -r /root/* /home/ubuntu/ 2>/dev/null || true
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
