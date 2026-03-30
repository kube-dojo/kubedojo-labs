#!/bin/bash
# Solution: Create tmpfs mount
mkdir -p /mnt/ramdisk
mount -t tmpfs -o size=50M tmpfs /mnt/ramdisk
df -h /mnt/ramdisk
