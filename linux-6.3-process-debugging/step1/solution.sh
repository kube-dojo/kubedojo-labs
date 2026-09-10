#!/bin/bash
# Solution: Trace ls command
strace ls /tmp 2> "$HOME"/strace-output.txt
cat "$HOME"/strace-output.txt | head -20
