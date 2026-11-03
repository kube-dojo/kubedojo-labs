#!/bin/bash
set -e
if id ubuntu &>/dev/null; then USER_HOME=/home/ubuntu; else USER_HOME=/root; fi
sudo apt install -y wget
wget --version > "$USER_HOME/wget-version.txt"
