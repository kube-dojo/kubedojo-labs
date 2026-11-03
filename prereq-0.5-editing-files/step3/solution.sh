#!/bin/bash
set -e
if id ubuntu &>/dev/null; then USER_HOME=/home/ubuntu; else USER_HOME=/root; fi
sed -i -e 's/sever/server/g' -e 's/listn/listen/g' "$USER_HOME/configs/nginx.conf"
