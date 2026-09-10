#!/bin/bash
# Verify: named netns lab-net exists AND its loopback is up with 127.0.0.1/8.
if ! ip netns list 2>/dev/null | grep -qw lab-net; then
  echo "FAIL: network namespace 'lab-net' not found"
  exit 1
fi
if ! ip -n lab-net link show lo 2>/dev/null | head -n1 | grep -q 'LOOPBACK,UP'; then
  echo "FAIL: loopback inside lab-net is not up — bring it up with 'ip -n lab-net link set lo up'"
  exit 1
fi
if ! ip -n lab-net -4 address show lo 2>/dev/null | grep -q '127\.0\.0\.1/8'; then
  echo "FAIL: 127.0.0.1/8 is not configured on lo inside lab-net"
  exit 1
fi
echo "PASS: lab-net exists and its loopback is up"
exit 0
