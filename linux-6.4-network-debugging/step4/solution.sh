#!/bin/bash
# Solution: Capture packets (with timeout for Docker)
ping -c 3 127.0.0.1 > /dev/null 2>&1 &
curl -s http://localhost/ > /dev/null 2>&1 &
sudo timeout 10 tcpdump -c 10 -n -i any 2>&1 | head -15 > "$HOME"/tcpdump-output.txt || {
  echo "tcpdump requires elevated privileges or timed out" > "$HOME"/tcpdump-output.txt
  echo "Command: tcpdump -c 10 -n -i any" >> "$HOME"/tcpdump-output.txt
}
cat "$HOME"/tcpdump-output.txt
