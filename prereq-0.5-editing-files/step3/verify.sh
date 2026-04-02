#!/bin/bash
if id "ubuntu" &>/dev/null; then USER_HOME="/home/ubuntu"; else USER_HOME="/root"; fi
FILE="$USER_HOME/configs/nginx.conf"
grep -q "server {" "$FILE" && grep -q "listen 80" "$FILE" && ! grep -q "sever" "$FILE" && echo "PASS" && exit 0
exit 1