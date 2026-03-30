#!/bin/bash
# Verify www-data has read ACL on /root/shared.txt
if [ ! -f /root/shared.txt ]; then
  echo "/root/shared.txt does not exist"
  exit 1
fi

if getfacl /root/shared.txt 2>/dev/null | grep -q "user:www-data:r"; then
  echo "ACL for www-data is set correctly!"
  exit 0
else
  echo "Expected ACL entry user:www-data:r-- not found"
  exit 1
fi
