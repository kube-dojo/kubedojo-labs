#!/bin/bash
if id "ubuntu" &>/dev/null; then USER_HOME="/home/ubuntu"; else USER_HOME="/root"; fi
FILE="$USER_HOME/curl-info.txt"
[ -f "$FILE" ] && grep -q "Package: curl" "$FILE" && echo "PASS" && exit 0
exit 1