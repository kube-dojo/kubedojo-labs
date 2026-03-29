#!/bin/bash
# Verify htop is installed and version file exists
which htop > /dev/null 2>&1 || exit 1
[ -f /home/user/htop-version.txt ] || exit 1
exit 0
