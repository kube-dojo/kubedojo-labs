#!/bin/bash
REVISIONS=$(helm history web 2>/dev/null | tail -n +2 | wc -l | tr -d ' ')
if [ "$REVISIONS" -ge 3 ]; then
  echo "PASS: Release 'web' has $REVISIONS revisions (need >= 3)"
  exit 0
else
  echo "FAIL: Release 'web' should have at least 3 revisions, found $REVISIONS"
  exit 1
fi
