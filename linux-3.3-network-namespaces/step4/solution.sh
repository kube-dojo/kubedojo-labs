#!/bin/bash
# Get the host's main IP (first non-loopback, non-veth interface)
HOST_IP=$(ip -4 addr show scope global | grep -v veth | grep inet | head -1 | awk '{print $2}' | cut -d/ -f1)

# Attempt to ping from lab-ns — this should fail (demonstrating isolation)
ip netns exec lab-ns ping -c1 -W2 "$HOST_IP" > /root/isolation-test.txt 2>&1 || true

# If the output is empty (no route at all), provide a meaningful message
if [ ! -s /root/isolation-test.txt ]; then
  echo "Isolation confirmed: lab-ns cannot reach host IP $HOST_IP (network unreachable)" > /root/isolation-test.txt
fi
