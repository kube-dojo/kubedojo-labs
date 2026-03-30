#!/bin/bash
if [ ! -f /root/bookmarks.txt ]; then
  echo "FAIL: /root/bookmarks.txt does not exist"
  exit 1
fi

URL_COUNT=$(grep -c "kubernetes.io" /root/bookmarks.txt)
if [ "$URL_COUNT" -ge 4 ]; then
  echo "PASS: File contains $URL_COUNT kubernetes.io URLs (need >= 4)"
  exit 0
else
  echo "FAIL: File should contain at least 4 kubernetes.io URLs, found $URL_COUNT"
  exit 1
fi
