#!/bin/bash
# Setup for USE Method lab
apt-get update -qq
apt-get install -y -qq sysstat procps > /dev/null 2>&1
echo "Setup complete."

# Seed /home/ubuntu if it exists
if [ -d /home/ubuntu ]; then
  cp -r /root/* /home/ubuntu/ 2>/dev/null || true
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
