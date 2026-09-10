#!/bin/bash
# Verify: whiteout semantics — hidden from merged, intact in lower, chardev in upper.
B=/tmp/kd-ufs
if ! findmnt -no FSTYPE "$B/merged" 2>/dev/null | grep -qx overlay; then
  echo "FAIL: overlay is not mounted — complete step 1 first"
  exit 1
fi
if [ -e "$B/merged/delete.txt" ]; then
  echo "FAIL: delete.txt is still visible in the merged view — delete it through merged"
  exit 1
fi
if [ "$(cat "$B/lower/delete.txt" 2>/dev/null)" != "delete me" ]; then
  echo "FAIL: lower/delete.txt is gone or changed — the lower layer must keep the original; delete via the MERGED view only"
  exit 1
fi
if [ ! -c "$B/upper/delete.txt" ]; then
  echo "FAIL: upper/delete.txt is not a character-device whiteout — the deletion was not recorded by the overlay"
  exit 1
fi
if [ ! -s "$B/evidence/upper-after-delete.txt" ] || ! grep -E '^c.*delete\.txt' "$B/evidence/upper-after-delete.txt" >/dev/null; then
  echo "FAIL: evidence/upper-after-delete.txt must record the upper long listing showing the whiteout (a line starting with 'c' for delete.txt)"
  exit 1
fi
echo "PASS: whiteout proven — deletion is a marker above, not removal below"
exit 0
