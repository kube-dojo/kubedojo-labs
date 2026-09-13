#!/bin/bash
# Setup for package and user management lab
apt-get update -qq
echo "Setup complete."


if [ -d /home/ubuntu ]; then
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
