#!/bin/bash
set -e
if id ubuntu &>/dev/null; then USER_HOME=/home/ubuntu; else USER_HOME=/root; fi
cd "$USER_HOME/documents"
cat welcome.txt
echo DOJO123 > "$USER_HOME/code.txt"
