#!/bin/bash
# Solution: Get primary IP address
hostname -I | awk '{print $1}' > /root/my-ip.txt
cat /root/my-ip.txt
