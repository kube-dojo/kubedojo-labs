#!/bin/bash
# Solution: Extract memory stats
free -m | awk '/^Mem:/ {printf "Total: %sMB\nUsed: %sMB\nAvailable: %sMB\n", $2, $3, $7}' > /root/mem-stats.txt
cat /root/mem-stats.txt
