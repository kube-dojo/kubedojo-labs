#!/bin/bash
# Verify: a real overlay is mounted with the expected layers and seeded content.
B=/tmp/kd-ufs
if ! findmnt -no FSTYPE "$B/merged" 2>/dev/null | grep -qx overlay; then
  echo "FAIL: no live overlay mount at $B/merged — run the mount command"
  exit 1
fi
opts=$(findmnt -no OPTIONS "$B/merged")
if ! printf '%s' "$opts" | grep -q "lowerdir=$B/lower" || ! printf '%s' "$opts" | grep -q "upperdir=$B/upper"; then
  echo "FAIL: overlay mounted with wrong layers (options: $opts)"
  exit 1
fi
for f in base.txt modify.txt delete.txt; do
  if [ ! -f "$B/merged/$f" ]; then
    echo "FAIL: $f missing from the merged view — seed the lower layer before mounting"
    exit 1
  fi
done
if [ "$(cat "$B/lower/base.txt" 2>/dev/null)" != "base file" ]; then
  echo "FAIL: lower/base.txt must contain exactly 'base file'"
  exit 1
fi
if [ ! -s "$B/evidence/mount-info.txt" ] || ! grep -q overlay "$B/evidence/mount-info.txt"; then
  echo "FAIL: evidence/mount-info.txt must record the live findmnt overlay line"
  exit 1
fi
if [ ! -s "$B/evidence/merged-list.txt" ] || ! grep -q base.txt "$B/evidence/merged-list.txt"; then
  echo "FAIL: evidence/merged-list.txt must record the merged directory listing"
  exit 1
fi
echo "PASS: overlay stack mounted — lower layer visible through the merged view"
exit 0
