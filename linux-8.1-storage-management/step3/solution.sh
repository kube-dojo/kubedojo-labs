#!/bin/bash
# Solution: Disk usage analysis
du -sh /* 2>/dev/null | sort -rh | head -10 > "$HOME"/disk-usage.txt
cat "$HOME"/disk-usage.txt
