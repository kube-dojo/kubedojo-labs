#!/bin/bash
if helm version 2>/dev/null | grep -q "Version"; then
  echo "PASS: Helm is installed"
  exit 0
else
  echo "FAIL: Helm is not installed or not working"
  exit 1
fi
