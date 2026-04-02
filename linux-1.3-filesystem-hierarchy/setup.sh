#!/bin/bash
# Setup for Filesystem Hierarchy lab
# No special setup needed
echo "Setup complete."

# Seed /home/ubuntu if it exists
if [ -d /home/ubuntu ]; then
  cp -r /root/* /home/ubuntu/ 2>/dev/null || true
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi

# KubeDojo Universal Seed
if [ -d /home/ubuntu ]; then
  cp -r /root/.[a-zA-Z]* /home/ubuntu/ 2>/dev/null || true
  cp -r /root/* /home/ubuntu/ 2>/dev/null || true
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
