#!/bin/bash
# Verify: chown succeeded with the capability and failed without it.
F=/tmp/kd-caps/testfile
EV=/tmp/kd-caps/drop-fail.txt
if [ ! -f "$F" ]; then
  echo "FAIL: $F missing — re-run the lab setup"
  exit 1
fi
owner=$(stat -c '%U' "$F")
if [ "$owner" != "nobody" ]; then
  echo "FAIL: live owner of testfile is '$owner', expected 'nobody' — the full-capability chown must succeed and the dropped-capability chown must fail"
  exit 1
fi
if [ ! -s "$EV" ]; then
  echo "FAIL: drop-fail.txt missing — record the error from the capsh --drop=cap_chown attempt"
  exit 1
fi
if ! grep -qi 'not permitted' "$EV"; then
  echo "FAIL: drop-fail.txt does not contain the kernel's 'Operation not permitted' refusal"
  exit 1
fi
echo "PASS: identical operation, identical UID — the missing capability alone made the kernel refuse"
exit 0
