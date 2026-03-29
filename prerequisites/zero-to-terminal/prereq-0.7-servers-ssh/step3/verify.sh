#!/bin/bash
# Verify ssh-port.txt exists and contains 22
[ -f /home/user/ssh-port.txt ] || exit 1
grep -q "22" /home/user/ssh-port.txt || exit 1
exit 0
