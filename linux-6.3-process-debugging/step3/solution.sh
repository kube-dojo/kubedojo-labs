#!/bin/bash
# Solution: Trace library calls
ltrace ls /tmp 2> /root/ltrace-output.txt
cat /root/ltrace-output.txt | head -20
