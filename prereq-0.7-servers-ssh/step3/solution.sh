#!/bin/bash
set -e
if id ubuntu &>/dev/null; then USER_HOME=/home/ubuntu; else USER_HOME=/root; fi
awk '/^[[:space:]]*Port[[:space:]]+/ {print $2; found=1; exit} END {if (!found) print 22}' /etc/ssh/sshd_config > "$USER_HOME/ssh-port.txt"
