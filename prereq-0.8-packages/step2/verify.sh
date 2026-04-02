#!/bin/bash
if id "ubuntu" &>/dev/null; then USER_HOME="/home/ubuntu"; else USER_HOME="/root"; fi
FILE="$USER_HOME/wget-version.txt"
[ -f "$FILE" ] && grep -qi "wget" "$FILE" && echo "PASS" && exit 0
exit 1