#!/bin/bash
if id "ubuntu" &>/dev/null; then USER_HOME="/home/ubuntu"; else USER_HOME="/root"; fi
FILE="$USER_HOME/ports.txt"
[ -f "$FILE" ] && grep -q ":80" "$FILE" && echo "PASS" && exit 0
exit 1