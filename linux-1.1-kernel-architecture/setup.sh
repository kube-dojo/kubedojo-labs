#!/bin/bash
# Setup for Kernel Architecture lab
# No special setup needed - the kernel is always there
echo "Setup complete."

if [ -d /home/ubuntu ]; then
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
