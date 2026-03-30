#!/bin/bash
if [ ! -f /root/node-metrics.txt ]; then
  echo "FAIL: /root/node-metrics.txt not found"
  exit 1
fi
if [ ! -f /root/pod-metrics.txt ]; then
  echo "FAIL: /root/pod-metrics.txt not found"
  exit 1
fi
if ! grep -qi "cpu\|NAME" /root/node-metrics.txt 2>/dev/null; then
  # Metrics might not have header
  if [ ! -s /root/node-metrics.txt ]; then
    echo "FAIL: node-metrics.txt is empty"
    exit 1
  fi
fi
echo "PASS"
exit 0
