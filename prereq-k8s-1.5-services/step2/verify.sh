#!/bin/bash
# Verify curl output file exists and contains nginx content
[ -f /root/curl-output.txt ] || exit 1
# Check for nginx welcome page content
grep -qi "nginx\|welcome" /root/curl-output.txt 2>/dev/null || exit 1
exit 0
