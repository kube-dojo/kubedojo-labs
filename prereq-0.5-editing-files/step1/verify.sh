#!/bin/bash
if id "ubuntu" &>/dev/null; then USER_HOME="/home/ubuntu"; else USER_HOME="/root"; fi
FILE="$USER_HOME/configs/app.env"
[ -f "$FILE" ] && awk 'NR == 1 {ok = ($0 == "APP_NAME=kubedojo")} NR == 2 {ok = ok && ($0 == "APP_PORT=8080")} NR == 3 {ok = ok && ($0 == "DB_HOST=localhost")} NR == 4 {ok = ok && ($0 == "DB_PORT=5432")} END {exit !(NR == 4 && ok)}' "$FILE" && echo "PASS" && exit 0
echo "FAIL: app.env not created correctly."
exit 1
