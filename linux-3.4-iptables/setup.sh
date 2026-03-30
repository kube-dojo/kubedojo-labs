#!/bin/bash
# Setup script for iptables Firewall and NAT lab

apt-get update -qq
apt-get install -y -qq iptables nginx curl > /dev/null 2>&1

# Ensure nginx is stopped (step 2 will start it)
systemctl stop nginx 2>/dev/null || true
pkill nginx 2>/dev/null || true

# Flush any existing rules for a clean slate
iptables -F 2>/dev/null || true
iptables -t nat -F 2>/dev/null || true
iptables -t mangle -F 2>/dev/null || true
iptables -X 2>/dev/null || true
iptables -t nat -X 2>/dev/null || true

echo "Setup complete."
