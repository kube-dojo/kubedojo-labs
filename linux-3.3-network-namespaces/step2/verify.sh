#!/bin/bash
# Verify that veth1 exists inside lab-ns
if ip netns exec lab-ns ip link show veth1 > /dev/null 2>&1; then
  echo "PASS: veth1 exists inside lab-ns"
  exit 0
else
  echo "FAIL: veth1 not found inside lab-ns namespace"
  exit 1
fi
