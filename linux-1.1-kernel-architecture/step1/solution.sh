#!/bin/bash
# Solution: Kernel version and module count
uname -r > "$HOME"/kernel-version.txt
# lsmod may show 0 modules in Docker (no /proc/modules or empty)
count=$(lsmod 2>/dev/null | tail -n +2 | wc -l)
echo "$count" > "$HOME"/module-count.txt
echo "Kernel: $(cat "$HOME"/kernel-version.txt)"
echo "Modules: $(cat "$HOME"/module-count.txt)"
