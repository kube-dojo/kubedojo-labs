#!/bin/bash
# Solution: Resolve google.com
dig google.com +short | head -1 > "$HOME"/google-ip.txt
cat "$HOME"/google-ip.txt
