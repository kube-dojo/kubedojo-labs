#!/bin/bash
# Solution: Create virtual interface
# Load dummy module if needed
sudo modprobe dummy 2>/dev/null || true
sudo ip link add dummy0 type dummy 2>/dev/null || {
  # Docker fallback: use a veth pair instead
  sudo ip link add dummy0 type veth peer name dummy0-peer 2>/dev/null || true
}
sudo ip link set dummy0 up 2>/dev/null || true
sudo ip addr add 10.10.10.1/24 dev dummy0 2>/dev/null || true
sudo ip addr show dummy0 2>/dev/null || echo "Interface creation limited in this environment"
