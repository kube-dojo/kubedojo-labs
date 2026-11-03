#!/bin/bash
if id "ubuntu" &>/dev/null; then USER_HOME="/home/ubuntu"; else USER_HOME="/root"; fi
BASE="$USER_HOME/lab-workspace"

[ -f "$BASE/backup/report.txt" ] && \
cmp -s "$BASE/backup/report.txt" "$BASE/docs/drafts/report.txt" && \
[ -f "$BASE/docs/archive/notes.txt" ] && \
[ ! -e "$BASE/docs/drafts/notes.txt" ] && \
grep -qx 'Remember to review the PR before Friday.' "$BASE/docs/archive/notes.txt" && \
[ -f "$BASE/docs/archive/historical_data.csv" ] && \
grep -qx 'id,name,value' "$BASE/docs/archive/historical_data.csv" && \
[ ! -e "$BASE/docs/archive/old_data.csv" ] && \
echo "PASS: Step 1 verified!" && exit 0

echo "FAIL: Files not moved/copied correctly."
exit 1
