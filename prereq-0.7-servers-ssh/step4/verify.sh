#!/bin/bash
if id "ubuntu" &>/dev/null; then USER_HOME="/home/ubuntu"; else USER_HOME="/root"; fi
FILE="$USER_HOME/checksum.txt"
[ -f "$FILE" ] && cmp -s "$FILE" <(md5sum "$USER_HOME/important-data.bin") && echo "PASS" && exit 0
exit 1
