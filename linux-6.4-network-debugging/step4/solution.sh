#!/bin/bash
# Solution: Capture packets
curl -s http://localhost/ > /dev/null 2>&1 &
tcpdump -c 10 -n 2>&1 | head -15 > /root/tcpdump-output.txt
cat /root/tcpdump-output.txt
