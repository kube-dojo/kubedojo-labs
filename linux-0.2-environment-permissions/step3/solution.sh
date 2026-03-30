#!/bin/bash
# Solution: Find all SUID binaries
find / -perm -4000 -type f 2>/dev/null > /root/suid-bins.txt
cat /root/suid-bins.txt
