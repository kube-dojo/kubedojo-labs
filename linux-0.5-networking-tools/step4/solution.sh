#!/bin/bash
# Solution: List all listening TCP ports
ss -tlnp > "$HOME"/listening-ports.txt
cat "$HOME"/listening-ports.txt
