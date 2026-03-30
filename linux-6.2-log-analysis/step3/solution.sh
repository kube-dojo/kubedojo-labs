#!/bin/bash
# Solution: Extract recent log entries
awk '$1 >= "2026-03-29T10:00:05"' /root/app.log > /root/recent-logs.txt
cat /root/recent-logs.txt
