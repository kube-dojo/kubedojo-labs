#!/bin/bash
# Solution: Create file with umask 027
umask 027
touch /root/umask-test.txt
stat -c '%a' /root/umask-test.txt
