#!/bin/bash
HISTORY=$(kubectl rollout history deployment/web-deploy -n practice 2>/dev/null)
COUNT=$(echo "$HISTORY" | tail -n +2 | wc -l | tr -d ' ')

if [ "$COUNT" -lt 3 ]; then
  echo "FAIL: Expected at least 3 revisions, found $COUNT"
  exit 1
fi

# Check for specific change causes
if echo "$HISTORY" | grep -q "update to nginx:1.26"; then
  echo "PASS: Rollout history verified with change causes"
  exit 0
else
  echo "FAIL: History found but 'change-cause' annotations are missing or incorrect"
  exit 1
fi