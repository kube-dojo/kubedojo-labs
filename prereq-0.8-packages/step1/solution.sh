#!/bin/bash
set -e
if id ubuntu &>/dev/null; then USER_HOME=/home/ubuntu; else USER_HOME=/root; fi
sudo apt update
apt show curl > "$USER_HOME/curl-info.txt"
