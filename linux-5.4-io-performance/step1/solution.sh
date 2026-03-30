#!/bin/bash
# Solution: Save iostat output
iostat -xz 1 1 > /root/iostat.txt
cat /root/iostat.txt
