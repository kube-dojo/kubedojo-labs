#!/bin/bash
# Solution: Extract unique sorted IPs from access.log
awk '{print $1}' "$HOME"/access.log | sort -u > "$HOME"/unique-ips.txt
cat "$HOME"/unique-ips.txt
