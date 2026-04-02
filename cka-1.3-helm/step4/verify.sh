#!/bin/bash
HISTORY=$(helm history web 2>/dev/null)
COUNT=$(echo "$HISTORY" | tail -n +2 | wc -l | tr -d ' ')

if [ "$COUNT" -lt 3 ]; then
  echo "FAIL: Expected at least 3 revisions, found $COUNT"
  exit 1
fi

# The latest revision should be a rollback to 1
REVISION=$(echo "$HISTORY" | tail -1 | awk '{print $1}')
DESCRIPTION=$(echo "$HISTORY" | tail -1 | cut -f 5- -d' ')

if echo "$DESCRIPTION" | grep -q "Rollback to 1"; then
  echo "PASS: Release has 3 revisions and latest is a rollback to 1"
  exit 0
else
  echo "FAIL: Latest revision is not a rollback to 1. Found: $DESCRIPTION"
  exit 1
fi