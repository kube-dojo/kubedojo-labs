#!/bin/bash
# Solution: Scan for open ports
nmap localhost > /root/port-scan.txt
cat /root/port-scan.txt
