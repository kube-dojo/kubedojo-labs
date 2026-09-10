#!/bin/bash
# Solution: Trace library calls
ltrace ls /tmp 2> "$HOME"/ltrace-output.txt
cat "$HOME"/ltrace-output.txt | head -20
