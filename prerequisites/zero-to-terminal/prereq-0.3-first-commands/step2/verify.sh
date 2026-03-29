#!/bin/bash
# Verify user created the directory and file
[ -d /home/user/projects/lab-results ] || exit 1
[ -f /home/user/projects/lab-results/step2.txt ] || exit 1
grep -q "step 2 complete" /home/user/projects/lab-results/step2.txt 2>/dev/null || exit 1
exit 0
