#!/bin/bash
# Solution: Start process with nice -10
sudo nice -n -10 sleep 300 &
sleep 1
PID=$(pgrep -f "sleep 300" | head -1)
cat > "$HOME"/nice-process.txt << EOF
PID: $PID
Nice: -10
EOF
cat "$HOME"/nice-process.txt
