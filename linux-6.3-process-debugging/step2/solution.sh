#!/bin/bash
# Solution: List open files
PID=$(cat "$HOME"/target-pid.txt)
lsof -p "$PID" > "$HOME"/open-files.txt
cat "$HOME"/open-files.txt
