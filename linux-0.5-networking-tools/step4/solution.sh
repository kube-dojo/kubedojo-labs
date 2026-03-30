#!/bin/bash
# Solution: List all listening TCP ports
ss -tlnp > /root/listening-ports.txt
cat /root/listening-ports.txt
