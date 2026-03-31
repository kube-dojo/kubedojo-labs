#!/bin/bash
# Solution: Capture packets (with timeout for Docker)
ping -c 3 127.0.0.1 > /dev/null 2>&1 &
curl -s http://localhost/ > /dev/null 2>&1 &
timeout 10 tcpdump -c 10 -n -i any 2>&1 | head -15 > /root/tcpdump-output.txt || {
  echo "tcpdump requires elevated privileges or timed out" > /root/tcpdump-output.txt
  echo "Command: tcpdump -c 10 -n -i any" >> /root/tcpdump-output.txt
}
cat /root/tcpdump-output.txt
