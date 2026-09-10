#!/bin/bash
# Solution: Count .conf files in /etc
find /etc -name "*.conf" 2>/dev/null | wc -l > "$HOME"/conf-count.txt
cat "$HOME"/conf-count.txt
