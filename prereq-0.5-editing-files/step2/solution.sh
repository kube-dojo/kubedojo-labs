#!/bin/bash
set -e
if id ubuntu &>/dev/null; then USER_HOME=/home/ubuntu; else USER_HOME=/root; fi
FILE="$USER_HOME/configs/app.env"
test -f "$FILE"
grep -qx 'LOG_LEVEL=info' "$FILE" || echo 'LOG_LEVEL=info' >> "$FILE"
grep -qx 'DEBUG=false' "$FILE" || echo 'DEBUG=false' >> "$FILE"
