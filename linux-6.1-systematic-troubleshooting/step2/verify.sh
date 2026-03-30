#!/bin/bash
if [ ! -f /root/failed-service.txt ]; then
  echo "FAIL: /root/failed-service.txt not found"
  exit 1
fi

if [ -s /root/failed-service.txt ]; then
  echo "PASS: failed-service.txt has content: $(cat /root/failed-service.txt)"
  exit 0
else
  echo "FAIL: failed-service.txt is empty"
  exit 1
fi
