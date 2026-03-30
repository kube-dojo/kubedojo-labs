#!/bin/bash
# Solution: Count .conf files in /etc
find /etc -name "*.conf" 2>/dev/null | wc -l > /root/conf-count.txt
cat /root/conf-count.txt
