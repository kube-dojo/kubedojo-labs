#!/bin/bash
if id "ubuntu" &>/dev/null; then USER_HOME="/home/ubuntu"; else USER_HOME="/root"; fi
BASE="$USER_HOME/lab-workspace"

[ -f "$BASE/backup/report.txt" ] && \
[ -f "$BASE/docs/archive/notes.txt" ] && \
[ -f "$BASE/docs/archive/historical_data.csv" ] && \
[ ! -f "$BASE/docs/archive/old_data.csv" ] && \
echo "PASS: Step 1 verified!" && exit 0

echo "FAIL: Files not moved/copied correctly."
exit 1
