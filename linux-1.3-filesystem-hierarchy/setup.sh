#!/bin/bash
# Setup for Filesystem Hierarchy lab
# No special setup needed
echo "Setup complete."

if [ -d /home/ubuntu ]; then
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
