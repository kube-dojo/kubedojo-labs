#!/bin/bash
# Solution: Save open files limit
ulimit -n > "$HOME"/nofile-limit.txt
cat "$HOME"/nofile-limit.txt
