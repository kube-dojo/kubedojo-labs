#!/bin/bash
# Setup for network debugging lab
apt-get update -qq
apt-get install -y -qq iputils-ping traceroute dnsutils nmap tcpdump nginx netcat-openbsd > /dev/null 2>&1

# Start nginx for port scanning exercise
systemctl start nginx 2>/dev/null || service nginx start 2>/dev/null || nginx 2>/dev/null

echo "Setup complete."
