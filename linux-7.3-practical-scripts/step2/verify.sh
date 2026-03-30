#!/bin/bash
if [ ! -f /root/healthcheck.sh ]; then
  echo "FAIL: /root/healthcheck.sh not found"
  exit 1
fi

if [ ! -x /root/healthcheck.sh ]; then
  echo "FAIL: /root/healthcheck.sh is not executable"
  exit 1
fi

OUTPUT=$(/root/healthcheck.sh 2>&1)
CHECKS=$(echo "$OUTPUT" | grep -cE '\[(OK|WARN|CRITICAL)\]')

if [ "$CHECKS" -ge 4 ]; then
  echo "PASS: Health check produces $CHECKS status checks"
  exit 0
else
  echo "FAIL: Expected at least 4 status checks, got $CHECKS"
  exit 1
fi
