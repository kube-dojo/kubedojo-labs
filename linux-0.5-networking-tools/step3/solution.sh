#!/bin/bash
# Solution: Check if port 80 is open
# Ensure nginx is running first
pgrep -x nginx > /dev/null 2>&1 || nginx 2>/dev/null || true
sleep 1
if nc -z localhost 80 2>/dev/null; then echo "open"; else echo "closed"; fi > "$HOME"/port-check.txt
cat "$HOME"/port-check.txt
