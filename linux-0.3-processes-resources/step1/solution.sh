#!/bin/bash
# Solution: Get PID 1 process name
ps -p 1 -o comm= > "$HOME"/init-name.txt
cat "$HOME"/init-name.txt
