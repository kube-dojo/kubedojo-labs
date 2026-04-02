#!/bin/bash
if ! helm list 2>/dev/null | grep -q "web"; then
  echo "FAIL: No release named 'web' found in helm list"
  exit 1
fi

STATUS=$(helm status web -o json | jq -r '.info.status')
if [ "$STATUS" = "deployed" ]; then
  echo "PASS: Release 'web' is deployed"
  exit 0
else
  echo "FAIL: Release 'web' status is: $STATUS (expected 'deployed')"
  exit 1
fi