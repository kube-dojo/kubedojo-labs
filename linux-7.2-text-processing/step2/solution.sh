#!/bin/bash
# Solution: Uppercase keys in config file
sed 's/^\([^=]*\)/\U\1/' "$HOME"/app.conf > "$HOME"/sed-output.txt
cat "$HOME"/sed-output.txt
