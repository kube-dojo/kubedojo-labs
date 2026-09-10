#!/bin/bash
# Solution: Start background process, save PID, kill it
sleep 600 &
echo $! > "$HOME"/bg-pid.txt
kill $(cat "$HOME"/bg-pid.txt)
echo "Process $(cat "$HOME"/bg-pid.txt) killed."
