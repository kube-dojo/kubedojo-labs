#!/bin/bash
# Solution: Start process with nice -10
nice -n -10 sleep 300 &
PID=$!
cat > "$HOME"/nice-process.txt << EOF
PID: $PID
Nice: -10
EOF
cat "$HOME"/nice-process.txt
