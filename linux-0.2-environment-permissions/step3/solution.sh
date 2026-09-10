#!/bin/bash
# Solution: Find all SUID binaries
find / -perm -4000 -type f 2>/dev/null > "$HOME"/suid-bins.txt
cat "$HOME"/suid-bins.txt
