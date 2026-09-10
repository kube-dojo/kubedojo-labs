#!/bin/bash
# Solution: Save iostat output
iostat -xz 1 1 > "$HOME"/iostat.txt
cat "$HOME"/iostat.txt
