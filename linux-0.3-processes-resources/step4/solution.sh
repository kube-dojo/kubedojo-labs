#!/bin/bash
# Solution: Save open files limit
ulimit -n > /root/nofile-limit.txt
cat /root/nofile-limit.txt
