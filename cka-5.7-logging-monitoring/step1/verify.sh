#!/bin/bash
# Verify: app-logs.txt exists with content
[ -f /root/app-logs.txt ] && [ -s /root/app-logs.txt ] && exit 0 || exit 1
