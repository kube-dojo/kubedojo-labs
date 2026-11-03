#!/bin/bash
if id "ubuntu" &>/dev/null; then USER_HOME="/home/ubuntu"; else USER_HOME="/root"; fi
FILE="$USER_HOME/wget-version.txt"
# installed: the package is installed, with its executable available.
[ "$(dpkg-query -W -f='${Status}' wget 2>/dev/null)" = 'install ok installed' ] && command -v wget >/dev/null || exit 1
# version-output: save the entire reported version output.
[ -f "$FILE" ] && cmp -s "$FILE" <(wget --version) && echo "PASS" && exit 0
exit 1
