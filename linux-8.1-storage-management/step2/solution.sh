#!/bin/bash
# Solution: Create tmpfs mount
sudo mkdir -p /mnt/ramdisk
sudo mount -t tmpfs -o size=50M tmpfs /mnt/ramdisk
df -h /mnt/ramdisk
