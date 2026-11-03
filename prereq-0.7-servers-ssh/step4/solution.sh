#!/bin/bash
set -e
if id ubuntu &>/dev/null; then USER_HOME=/home/ubuntu; else USER_HOME=/root; fi
md5sum "$USER_HOME/important-data.bin" > "$USER_HOME/checksum.txt"
