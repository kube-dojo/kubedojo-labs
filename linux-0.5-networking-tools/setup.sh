#!/bin/bash
# Setup for Networking Tools lab

# Install required packages
apt-get update -qq && apt-get install -y -qq dnsutils nginx net-tools curl netcat-openbsd > /dev/null 2>&1

# Start nginx for connectivity testing
systemctl start nginx 2>/dev/null || nginx 2>/dev/null || true

echo "Setup complete."
