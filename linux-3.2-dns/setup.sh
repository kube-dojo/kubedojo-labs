#!/bin/bash
# Setup script for DNS Resolution and Troubleshooting lab

# Install DNS utilities
apt-get update -qq
apt-get install -y -qq dnsutils iputils-ping > /dev/null 2>&1

echo "Setup complete."


if [ -d /home/ubuntu ]; then
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
