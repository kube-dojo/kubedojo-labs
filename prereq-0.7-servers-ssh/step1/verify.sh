#!/bin/bash
if id "ubuntu" &>/dev/null; then USER_HOME="/home/ubuntu"; else USER_HOME="/root"; fi
[ -f "$USER_HOME/.ssh/lab_key" ] && [ -f "$USER_HOME/.ssh/lab_key.pub" ] && echo "PASS" && exit 0
exit 1