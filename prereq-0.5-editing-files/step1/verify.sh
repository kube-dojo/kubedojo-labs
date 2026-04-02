#!/bin/bash
if id "ubuntu" &>/dev/null; then USER_HOME="/home/ubuntu"; else USER_HOME="/root"; fi
FILE="$USER_HOME/configs/app.env"
[ -f "$FILE" ] && grep -q "APP_NAME=kubedojo" "$FILE" && grep -q "APP_PORT=8080" "$FILE" && [ "$(wc -l < "$FILE")" -ge 4 ] && echo "PASS" && exit 0
echo "FAIL: app.env not created correctly."
exit 1
