#!/bin/bash
# Solution: Count 5xx errors
awk '$9 ~ /^5/' "$HOME"/access.log | wc -l > "$HOME"/5xx-count.txt
echo "5xx error count: $(cat "$HOME"/5xx-count.txt)"
