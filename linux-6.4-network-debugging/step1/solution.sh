#!/bin/bash
# Solution: Test connectivity
(ping -c 4 8.8.8.8 || echo "Ping blocked - using alternative") > /root/connectivity.txt 2>&1
ip route get 8.8.8.8 >> /root/connectivity.txt 2>&1
cat /root/connectivity.txt
