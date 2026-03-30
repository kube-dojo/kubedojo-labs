#!/bin/bash
# Verify boot parameters analysis

if [ ! -f /root/boot-params.txt ]; then
  echo "FAIL: /root/boot-params.txt does not exist"
  exit 1
fi

# Check the file has meaningful content (at least a few lines)
LINES=$(wc -l < /root/boot-params.txt)
if [ "$LINES" -lt 2 ]; then
  echo "FAIL: /root/boot-params.txt has too little content ($LINES lines)"
  exit 1
fi

echo "PASS: Boot parameters analysis saved to /root/boot-params.txt"
exit 0
