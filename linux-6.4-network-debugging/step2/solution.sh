#!/bin/bash
# Solution: DNS debugging
dig google.com > "$HOME"/dns-debug.txt 2>&1
cat "$HOME"/dns-debug.txt
