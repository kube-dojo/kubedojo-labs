#!/bin/bash
# Solution: Test connectivity
(ping -c 4 8.8.8.8 || echo "Ping blocked - using alternative") > "$HOME"/connectivity.txt 2>&1
ip route get 8.8.8.8 >> "$HOME"/connectivity.txt 2>&1
cat "$HOME"/connectivity.txt
