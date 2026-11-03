#!/bin/bash
set -e
if id ubuntu &>/dev/null; then USER_HOME=/home/ubuntu; else USER_HOME=/root; fi
sudo service nginx start
ss -tlnp > "$USER_HOME/ports.txt"
