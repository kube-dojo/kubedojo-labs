#!/bin/bash
# Solution: Resolve google.com
dig google.com +short | head -1 > /root/google-ip.txt
cat /root/google-ip.txt
