#!/bin/bash
if id "ubuntu" &>/dev/null; then USER_HOME="/home/ubuntu"; else USER_HOME="/root"; fi
FILE="$USER_HOME/curl-info.txt"
# lists-present: apt update has populated package indexes.
find /var/lib/apt/lists -maxdepth 1 -type f -name '*_Packages*' -print -quit | grep -q . || exit 1
# curl-info: retain the full apt show output, not only its package label.
[ -f "$FILE" ] && cmp -s "$FILE" <(apt show curl 2>/dev/null) && echo "PASS" && exit 0
exit 1
