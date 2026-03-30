#!/bin/bash
for i in $(seq 1 30); do
  S=$(kubectl get pod debug-target -n debug-lab -o jsonpath='{.status.phase}' 2>/dev/null)
  [ "$S" = "Running" ] && break
  sleep 2
done
if [ "$S" != "Running" ]; then
  echo "FAIL: debug-target should be Running"
  exit 1
fi
if [ ! -f /root/nginx-version.txt ]; then
  echo "FAIL: /root/nginx-version.txt not found"
  exit 1
fi
if [ ! -f /root/nginx-config-list.txt ]; then
  echo "FAIL: /root/nginx-config-list.txt not found"
  exit 1
fi
if [ ! -f /root/dns-server.txt ]; then
  echo "FAIL: /root/dns-server.txt not found"
  exit 1
fi
echo "PASS"
exit 0
