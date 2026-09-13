#!/bin/bash
# Setup for Processes and systemd Deep Dive lab
# No special setup needed
echo "Setup complete."

if [ -d /home/ubuntu ]; then
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
