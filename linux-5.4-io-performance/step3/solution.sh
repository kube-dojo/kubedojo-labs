#!/bin/bash
# Solution: Run I/O benchmark
dd if=/dev/zero of=/tmp/benchmark bs=1M count=100 conv=fdatasync 2>&1 | tail -1 > /root/io-benchmark.txt
cat /root/io-benchmark.txt
rm -f /tmp/benchmark
