#!/bin/bash
# Setup script for Network Namespaces lab

# Ensure iproute2 is available
apt-get update -qq
apt-get install -y -qq iproute2 iputils-ping > /dev/null 2>&1

# Create /run/netns directory if missing (needed for ip netns in Docker)
mkdir -p /run/netns

# Clean up any leftover namespaces from previous runs
ip netns del lab-ns 2>/dev/null || true
ip link del veth0 2>/dev/null || true

echo "Setup complete."
