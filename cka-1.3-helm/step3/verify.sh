#!/bin/bash
if helm list 2>/dev/null | grep -q "web"; then
  echo "PASS: Release 'web' exists"
  exit 0
else
  echo "FAIL: No release named 'web' found in helm list"
  exit 1
fi
