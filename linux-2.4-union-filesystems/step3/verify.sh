#!/bin/bash
# Verify: copy-up happened — upper holds the change, lower holds the original.
B=/tmp/kd-ufs
if ! findmnt -no FSTYPE "$B/merged" 2>/dev/null | grep -qx overlay; then
  echo "FAIL: overlay is not mounted — complete step 1 first"
  exit 1
fi
if [ "$(cat "$B/upper/modify.txt" 2>/dev/null)" != "modified content" ]; then
  echo "FAIL: upper/modify.txt missing or wrong — modify modify.txt through the MERGED view"
  exit 1
fi
if [ "$(cat "$B/lower/modify.txt" 2>/dev/null)" != "original content" ]; then
  echo "FAIL: lower/modify.txt no longer holds 'original content' — the lower layer must never change; you edited it directly"
  exit 1
fi
if [ "$(cat "$B/merged/modify.txt" 2>/dev/null)" != "modified content" ]; then
  echo "FAIL: the merged view does not show the modified content"
  exit 1
fi
if [ "$(cat "$B/evidence/upper-modify.txt" 2>/dev/null)" != "modified content" ] || \
   [ "$(cat "$B/evidence/lower-modify.txt" 2>/dev/null)" != "original content" ]; then
  echo "FAIL: evidence files must record the upper copy ('modified content') and the untouched lower original ('original content')"
  exit 1
fi
echo "PASS: copy-on-write proven — upper shadows lower, lower stays pristine"
exit 0
