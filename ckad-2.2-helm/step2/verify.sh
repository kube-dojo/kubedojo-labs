#!/bin/bash
RELEASE=$(helm list -n helm-lab -o json 2>/dev/null | grep -o '"custom-app"' | head -1)
if [ -z "$RELEASE" ]; then
  echo "FAIL: custom-app release not found"
  exit 1
fi
if [ ! -f /root/custom-values.yaml ]; then
  echo "FAIL: /root/custom-values.yaml not found"
  exit 1
fi
if [ ! -f /root/custom-app-values.txt ]; then
  echo "FAIL: /root/custom-app-values.txt not found"
  exit 1
fi
echo "PASS"
exit 0
