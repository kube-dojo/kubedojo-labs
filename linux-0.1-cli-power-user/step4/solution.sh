#!/bin/bash
# Solution: Count total lines in all .log files under /var/log
sudo find /var/log -name "*.log" -type f 2>/dev/null | sudo xargs cat 2>/dev/null | wc -l > "$HOME"/total-lines.txt
cat "$HOME"/total-lines.txt
