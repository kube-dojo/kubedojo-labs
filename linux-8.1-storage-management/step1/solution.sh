#!/bin/bash
# Solution: List block devices
lsblk -o NAME,SIZE,TYPE,MOUNTPOINT > /root/block-devices.txt
cat /root/block-devices.txt
