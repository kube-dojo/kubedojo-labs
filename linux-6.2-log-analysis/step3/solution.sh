#!/bin/bash
# Solution: Extract recent log entries
awk '$1 >= "2026-03-29T10:00:05"' "$HOME"/app.log > "$HOME"/recent-logs.txt
cat "$HOME"/recent-logs.txt
