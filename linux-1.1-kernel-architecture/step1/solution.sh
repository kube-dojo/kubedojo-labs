#!/bin/bash
# Solution: Kernel version and module count
uname -r > /root/kernel-version.txt
# lsmod may show 0 modules in Docker (no /proc/modules or empty)
count=$(lsmod 2>/dev/null | tail -n +2 | wc -l)
echo "$count" > /root/module-count.txt
echo "Kernel: $(cat /root/kernel-version.txt)"
echo "Modules: $(cat /root/module-count.txt)"
