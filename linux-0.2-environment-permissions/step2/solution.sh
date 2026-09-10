#!/bin/bash
# Solution: Create file with umask 027
umask 027
touch "$HOME"/umask-test.txt
stat -c '%a' "$HOME"/umask-test.txt
