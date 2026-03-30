#!/bin/bash
for i in $(seq 1 30); do
  S=$(kubectl get pod search-app -n logging-lab -o jsonpath='{.status.phase}' 2>/dev/null)
  [ "$S" = "Running" ] && break
  sleep 2
done
if [ ! -f /root/error-logs.txt ]; then
  echo "FAIL: /root/error-logs.txt not found"
  exit 1
fi
if ! grep -q "ERROR" /root/error-logs.txt; then
  echo "FAIL: error-logs.txt should contain ERROR lines"
  exit 1
fi
if grep -q "INFO" /root/error-logs.txt; then
  echo "FAIL: error-logs.txt should NOT contain INFO lines"
  exit 1
fi
if [ ! -f /root/error-count.txt ]; then
  echo "FAIL: /root/error-count.txt not found"
  exit 1
fi
echo "PASS"
exit 0
