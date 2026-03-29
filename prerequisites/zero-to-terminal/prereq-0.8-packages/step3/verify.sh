#!/bin/bash
# Verify curl-path.txt contains /usr/bin/curl
[ -f /home/user/curl-path.txt ] || exit 1
grep -q "/usr/bin/curl" /home/user/curl-path.txt || exit 1

# Verify package-count.txt exists and contains a number
[ -f /home/user/package-count.txt ] || exit 1
COUNT=$(cat /home/user/package-count.txt | tr -d '[:space:]')
[[ "$COUNT" =~ ^[0-9]+$ ]] || exit 1
[ "$COUNT" -gt 0 ] || exit 1
exit 0
