#!/bin/bash
if id "ubuntu" &>/dev/null; then USER_HOME="/home/ubuntu"; else USER_HOME="/root"; fi
FILE="$USER_HOME/configs/nginx.conf"
! grep -qE 'sever|listn' "$FILE" && grep -q "server {" "$FILE" && grep -q "server_name localhost" "$FILE" && grep -q "listen 80" "$FILE" && echo "PASS" && exit 0
exit 1
