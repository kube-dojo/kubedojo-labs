#!/bin/bash
# Verify ports.txt exists and contains port 80
[ -f /home/user/ports.txt ] || exit 1
grep -q ":80" /home/user/ports.txt || exit 1
exit 0
