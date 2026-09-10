#!/bin/bash
# Verify: A/C/D report matches the real upper layer; unmounted; lower pristine.
B=/tmp/kd-ufs
EV=$B/evidence/diff-report.txt
if [ ! -s "$EV" ]; then
  echo "FAIL: evidence/diff-report.txt missing — build the A/C/D report from the upper layer"
  exit 1
fi
if findmnt -no FSTYPE "$B/merged" 2>/dev/null | grep -qx overlay; then
  echo "FAIL: the overlay is still mounted at $B/merged — unmount it after building the report"
  exit 1
fi
expected=$(for f in "$B"/upper/*; do
  [ -e "$f" ] || continue
  n=$(basename "$f")
  if [ -c "$f" ]; then echo "D $n"
  elif [ -e "$B/lower/$n" ]; then echo "C $n"
  else echo "A $n"; fi
done | sort)
recorded=$(sort "$EV")
if [ "$recorded" != "$expected" ]; then
  echo "FAIL: diff-report.txt does not match the real upper layer (expected: $(echo $expected))"
  exit 1
fi
if ! printf '%s\n' "$expected" | grep -qx "A new.txt" || \
   ! printf '%s\n' "$expected" | grep -qx "C modify.txt" || \
   ! printf '%s\n' "$expected" | grep -qx "D delete.txt"; then
  echo "FAIL: the upper layer does not contain the expected A/C/D history — complete steps 2-4 first"
  exit 1
fi
if [ "$(cat "$B/lower/base.txt" 2>/dev/null)" != "base file" ] || \
   [ "$(cat "$B/lower/modify.txt" 2>/dev/null)" != "original content" ] || \
   [ "$(cat "$B/lower/delete.txt" 2>/dev/null)" != "delete me" ]; then
  echo "FAIL: the lower layer changed — after a full write/modify/delete cycle the 'image' must be bit-for-bit intact"
  exit 1
fi
echo "PASS: docker-diff semantics reconstructed from the writable layer; image layer survived untouched"
exit 0
