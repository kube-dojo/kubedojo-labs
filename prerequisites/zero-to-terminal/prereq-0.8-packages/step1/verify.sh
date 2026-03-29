#!/bin/bash
# Verify curl-info.txt exists and contains package info
[ -f /home/user/curl-info.txt ] || exit 1
grep -q "Package: curl" /home/user/curl-info.txt || exit 1
exit 0
