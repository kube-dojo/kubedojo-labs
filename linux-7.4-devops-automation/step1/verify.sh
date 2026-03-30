#!/bin/bash
if [ ! -f /root/app.conf ]; then
  echo "FAIL: /root/app.conf not found"
  exit 1
fi

if grep -q '${' /root/app.conf; then
  echo "FAIL: /root/app.conf still contains unresolved \${} placeholders"
  exit 1
fi

echo "PASS: app.conf has no unresolved placeholders"
exit 0
