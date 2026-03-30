#!/bin/bash
if grep -q "alias k=kubectl" /root/.bashrc && grep -q "alias kgp=" /root/.bashrc; then
  echo "PASS: Aliases found in ~/.bashrc"
  exit 0
else
  echo "FAIL: Expected 'alias k=kubectl' and 'alias kgp=...' in ~/.bashrc"
  exit 1
fi
