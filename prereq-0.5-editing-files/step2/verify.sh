#!/bin/bash
if id "ubuntu" &>/dev/null; then USER_HOME="/home/ubuntu"; else USER_HOME="/root"; fi
FILE="$USER_HOME/configs/app.env"
[ -f "$FILE" ] && grep -q "LOG_LEVEL=info" "$FILE" && [ "$(wc -l < "$FILE")" -ge 6 ] && echo "PASS" && exit 0
exit 1