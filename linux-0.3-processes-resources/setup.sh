#!/bin/bash
# Setup for Processes and Resources lab
# Nothing special needed - the system already has processes running
echo "Setup complete."

if [ -d /home/ubuntu ]; then
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
