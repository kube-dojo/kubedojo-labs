#!/bin/bash
# Solution: DNS debugging
dig google.com > /root/dns-debug.txt 2>&1
cat /root/dns-debug.txt
