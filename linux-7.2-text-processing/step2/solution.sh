#!/bin/bash
# Solution: Uppercase keys in config file
sed 's/^\([^=]*\)/\U\1/' /root/app.conf > /root/sed-output.txt
cat /root/sed-output.txt
