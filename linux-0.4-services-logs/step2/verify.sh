#!/bin/bash
# Verify /root/nginx-journal.txt exists and has content
if [ ! -f /root/nginx-journal.txt ]; then
  echo "/root/nginx-journal.txt does not exist"
  exit 1
fi

if [ ! -s /root/nginx-journal.txt ]; then
  echo "/root/nginx-journal.txt is empty"
  exit 1
fi

echo "Journal output captured!"
exit 0
