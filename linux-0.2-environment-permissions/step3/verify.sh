#!/bin/bash
# Verify /root/suid-bins.txt exists and contains known SUID binaries
if [ ! -f /root/suid-bins.txt ]; then
  echo "/root/suid-bins.txt does not exist"
  exit 1
fi

if grep -q "passwd" /root/suid-bins.txt; then
  lines=$(wc -l < /root/suid-bins.txt | tr -d '[:space:]')
  echo "Found $lines SUID binaries including passwd. Good security audit!"
  exit 0
else
  echo "Expected to find /usr/bin/passwd in the list"
  exit 1
fi
