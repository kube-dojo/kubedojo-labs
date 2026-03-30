#!/bin/bash
# Solution: Observe page cache behavior
BEFORE=$(free -m | awk '/^Mem:/ {print $6}')
dd if=/dev/zero of=/tmp/testfile bs=1M count=100 2>/dev/null
AFTER=$(free -m | awk '/^Mem:/ {print $6}')
echo -e "Before: ${BEFORE}MB\nAfter: ${AFTER}MB" > /root/cache-test.txt
cat /root/cache-test.txt
