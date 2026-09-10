#!/bin/bash
# Solution: Extract memory stats
free -m | awk '/^Mem:/ {printf "Total: %sMB\nUsed: %sMB\nAvailable: %sMB\n", $2, $3, $7}' > "$HOME"/mem-stats.txt
cat "$HOME"/mem-stats.txt
