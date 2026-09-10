#!/bin/bash
# Solution: List unique process states
ps -eo stat --no-headers | cut -c1 | sort -u > "$HOME"/process-states.txt
cat "$HOME"/process-states.txt
