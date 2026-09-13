#!/bin/bash
# Setup for storage management lab
echo "Setup complete."


if [ -d /home/ubuntu ]; then
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
