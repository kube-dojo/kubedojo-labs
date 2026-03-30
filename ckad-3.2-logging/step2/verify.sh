#!/bin/bash
if [ ! -f /root/sidecar-logs.txt ]; then
  echo "FAIL: /root/sidecar-logs.txt not found"
  exit 1
fi
if ! grep -qi "sidecar\|health" /root/sidecar-logs.txt 2>/dev/null; then
  # May just have date output
  if [ ! -s /root/sidecar-logs.txt ]; then
    echo "FAIL: sidecar-logs.txt is empty"
    exit 1
  fi
fi
if [ ! -f /root/container-names.txt ]; then
  echo "FAIL: /root/container-names.txt not found"
  exit 1
fi
NAMES=$(cat /root/container-names.txt)
if [[ "$NAMES" != *"app"* ]] || [[ "$NAMES" != *"sidecar"* ]]; then
  echo "FAIL: container-names.txt should contain app and sidecar"
  exit 1
fi
echo "PASS"
exit 0
