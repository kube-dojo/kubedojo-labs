#!/bin/bash
for f in trivy-nginx-old.txt trivy-nginx-latest.txt critical-count.txt trivy-report.json; do
  if [ ! -f "/root/$f" ] || [ ! -s "/root/$f" ]; then
    echo "FAIL: /root/$f missing or empty"
    exit 1
  fi
done
if ! python3 -c "import json; json.load(open('/root/trivy-report.json'))" 2>/dev/null; then
  echo "FAIL: trivy-report.json is not valid JSON"
  exit 1
fi
echo "PASS"
exit 0
