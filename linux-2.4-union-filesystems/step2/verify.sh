#!/bin/bash
# Verify: new file landed in upper only; reading did not copy up; lower untouched.
B=/tmp/kd-ufs
if ! findmnt -no FSTYPE "$B/merged" 2>/dev/null | grep -qx overlay; then
  echo "FAIL: overlay is not mounted — complete step 1 first"
  exit 1
fi
if [ "$(cat "$B/evidence/read-through.txt" 2>/dev/null)" != "base file" ]; then
  echo "FAIL: evidence/read-through.txt must contain the lower file's content read via merged ('base file')"
  exit 1
fi
if [ "$(cat "$B/upper/new.txt" 2>/dev/null)" != "new file" ]; then
  echo "FAIL: upper/new.txt missing or wrong — create new.txt with 'new file' through the MERGED view"
  exit 1
fi
if [ -e "$B/lower/new.txt" ]; then
  echo "FAIL: new.txt exists in the LOWER layer — you wrote into lower directly; writes must go through merged"
  exit 1
fi
if [ -e "$B/upper/base.txt" ]; then
  echo "FAIL: base.txt was copied up to upper — a plain read never copies up; do not write to base.txt"
  exit 1
fi
if [ ! -s "$B/evidence/upper-after-new.txt" ] || ! grep -qx new.txt "$B/evidence/upper-after-new.txt"; then
  echo "FAIL: evidence/upper-after-new.txt must record the upper listing containing new.txt"
  exit 1
fi
echo "PASS: read served from lower, write landed in upper — the sharing model works"
exit 0
