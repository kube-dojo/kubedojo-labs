#!/bin/bash
# Solution: Scan for open ports
nmap localhost > "$HOME"/port-scan.txt
cat "$HOME"/port-scan.txt
