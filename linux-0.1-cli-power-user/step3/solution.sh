#!/bin/bash
# Solution: Extract unique sorted IPs from access.log
awk '{print $1}' /root/access.log | sort -u > /root/unique-ips.txt
cat /root/unique-ips.txt
