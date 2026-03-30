#!/bin/bash
HISTORY=$(helm history web-app -n helm-lab 2>/dev/null | wc -l)
if [ "$HISTORY" -lt 3 ]; then
  echo "FAIL: web-app should have at least 3 history entries (header + 2+ revisions)"
  exit 1
fi
if [ ! -f /root/helm-revision.txt ]; then
  echo "FAIL: /root/helm-revision.txt not found"
  exit 1
fi
REV=$(cat /root/helm-revision.txt | tr -d '[:space:]')
if [ -z "$REV" ] || [ "$REV" -lt 2 ]; then
  echo "FAIL: Revision should be at least 2 after rollback"
  exit 1
fi
echo "PASS"
exit 0
