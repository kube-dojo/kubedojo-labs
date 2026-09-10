#!/bin/bash
# Solution: Count files > 1MB in /usr
find /usr -type f -size +1M 2>/dev/null | wc -l > "$HOME"/large-files-count.txt
cat "$HOME"/large-files-count.txt
