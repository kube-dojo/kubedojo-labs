#!/bin/bash
if id "ubuntu" &>/dev/null; then USER_HOME="/home/ubuntu"; else USER_HOME="/root"; fi
FILE="$USER_HOME/ssh-port.txt"
PORT=$(awk '/^[[:space:]]*Port[[:space:]]+/ {print $2; found=1; exit} END {if (!found) print 22}' /etc/ssh/sshd_config) || exit 1
[ -f "$FILE" ] && awk -v port="$PORT" 'NR == 1 {ok = ($0 == port)} END {exit !(NR == 1 && ok)}' "$FILE" && echo "PASS" && exit 0
exit 1
