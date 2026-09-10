#!/bin/bash
# Verify: a real CapEff mask was recorded and its decode matches capsh's own answer.
MASK=/tmp/kd-caps/capeff.txt
DEC=/tmp/kd-caps/decoded.txt
if [ ! -s "$MASK" ] || [ ! -s "$DEC" ]; then
  echo "FAIL: evidence files missing — write capeff.txt and decoded.txt in /tmp/kd-caps/"
  exit 1
fi
mask=$(head -n1 "$MASK" | tr -d '[:space:]')
if ! printf '%s' "$mask" | grep -Eqi '^[0-9a-f]{16}$'; then
  echo "FAIL: capeff.txt is not a 16-digit hex capability mask (got: $mask) — record the CapEff value from /proc/self/status"
  exit 1
fi
if ! command -v capsh >/dev/null; then
  echo "FAIL: capsh not installed — re-run the lab setup (libcap2-bin)"
  exit 1
fi
expected=$(capsh --decode="$mask")
recorded=$(head -n1 "$DEC" | tr -d '[:space:]')
if [ "$recorded" != "$(printf '%s' "$expected" | tr -d '[:space:]')" ]; then
  echo "FAIL: decoded.txt does not match capsh --decode of your recorded mask — decode the same mask you recorded"
  exit 1
fi
echo "PASS: capability mask recorded and decoded consistently"
exit 0
