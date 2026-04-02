#!/bin/bash
if id "ubuntu" &>/dev/null; then USER_HOME="/home/ubuntu"; else USER_HOME="/root"; fi
FILE="$USER_HOME/checksum.txt"
EXPECTED="66a5f7fac1658423d3e0f3e1170b6b1d"
[ -f "$FILE" ] && grep -q "$EXPECTED" "$FILE" && echo "PASS" && exit 0
exit 1