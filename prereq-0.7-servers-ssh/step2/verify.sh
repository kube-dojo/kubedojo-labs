#!/bin/bash
if id "ubuntu" &>/dev/null; then USER_HOME="/home/ubuntu"; else USER_HOME="/root"; fi
FILE="$USER_HOME/ports.txt"
# running: nginx must be active independently of the saved output.
pgrep -x nginx >/dev/null || exit 1
# full-output: compare every line as the same user who ran the transcript.
if id ubuntu &>/dev/null; then
  OUTPUT=$(sudo -u ubuntu ss -tlnp) || exit 1
else
  OUTPUT=$(ss -tlnp) || exit 1
fi
[ -f "$FILE" ] && cmp -s "$FILE" <(printf '%s\n' "$OUTPUT") && echo "PASS" && exit 0
exit 1
