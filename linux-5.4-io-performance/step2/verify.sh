#!/bin/bash
if [ ! -f /root/io-scheduler.txt ]; then
  echo "FAIL: /root/io-scheduler.txt not found"
  exit 1
fi

CONTENT=$(cat /root/io-scheduler.txt | tr -d '[:space:]')
if echo "$CONTENT" | grep -qiE '(mq-deadline|deadline|bfq|kyber|none|noop|cfq)'; then
  echo "PASS: io-scheduler.txt contains a valid scheduler name: $CONTENT"
  exit 0
else
  echo "FAIL: io-scheduler.txt does not contain a recognized scheduler name"
  exit 1
fi
