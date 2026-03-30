#!/bin/bash
for f in iptables-before.txt iptables-rules.txt firewall-best-practices.txt; do
  if [ ! -f "/root/$f" ] || [ ! -s "/root/$f" ]; then
    echo "FAIL: /root/$f missing or empty"
    exit 1
  fi
done
LINES=$(wc -l < /root/firewall-best-practices.txt | tr -d ' ')
if [ "$LINES" -lt 4 ]; then
  echo "FAIL: Expected at least 4 firewall best practices"
  exit 1
fi
echo "PASS"
exit 0
