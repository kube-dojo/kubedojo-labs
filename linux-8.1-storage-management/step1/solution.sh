#!/bin/bash
# Solution: List block devices
lsblk -o NAME,SIZE,TYPE,MOUNTPOINT > "$HOME"/block-devices.txt
cat "$HOME"/block-devices.txt
