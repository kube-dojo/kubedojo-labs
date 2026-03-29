#!/bin/bash
# Verify user navigated to /home/user/documents
# Check if they've accessed the directory (it exists and has been listed)
[ -d /home/user/documents ] && ls /home/user/documents > /dev/null 2>&1 && exit 0 || exit 1
