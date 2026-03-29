#!/bin/bash
# Verify user found stopped services and saved to file
[ -f /home/user/projects/lab-results/stopped.txt ] || exit 1
# Should contain postgres and worker (both stopped)
grep -q "postgres" /home/user/projects/lab-results/stopped.txt 2>/dev/null || exit 1
grep -q "worker" /home/user/projects/lab-results/stopped.txt 2>/dev/null || exit 1
# Should NOT contain running services
grep -q "nginx" /home/user/projects/lab-results/stopped.txt 2>/dev/null && exit 1
exit 0
