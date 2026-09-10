#!/bin/bash
# Solution: Get primary IP address
hostname -I | awk '{print $1}' > "$HOME"/my-ip.txt
cat "$HOME"/my-ip.txt
