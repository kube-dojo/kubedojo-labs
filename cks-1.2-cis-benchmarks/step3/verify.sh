#!/bin/bash
CONFIG="/var/lib/kubelet/config.yaml"
if grep -q "anonymous:" "$CONFIG" && grep -A1 "anonymous:" "$CONFIG" | grep -q "enabled: true"; then
  echo "FAIL: Anonymous auth should be disabled"
  exit 1
fi
if ! grep -q "readOnlyPort: 0" "$CONFIG"; then
  echo "FAIL: readOnlyPort should be 0"
  exit 1
fi
if [ ! -f /root/kubelet-status.txt ] || [ ! -s /root/kubelet-status.txt ]; then
  echo "FAIL: /root/kubelet-status.txt missing or empty"
  exit 1
fi
echo "PASS"
exit 0
