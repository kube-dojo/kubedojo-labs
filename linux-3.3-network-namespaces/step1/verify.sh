#!/bin/bash
# Verify that the lab-ns namespace exists
if ip netns list | grep -q "lab-ns"; then
  echo "PASS: lab-ns namespace exists"
  exit 0
else
  echo "FAIL: lab-ns namespace not found"
  exit 1
fi
