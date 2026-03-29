#!/bin/bash
# Verify checksum.txt exists and contains the correct md5 for "kubedojo-integrity-test" (no newline)
[ -f /home/user/checksum.txt ] || exit 1
# The expected md5 of "kubedojo-integrity-test" (echo -n)
EXPECTED="66a5f7fac1658423d3e0f3e1170b6b1d"
grep -q "$EXPECTED" /home/user/checksum.txt || exit 1
exit 0
