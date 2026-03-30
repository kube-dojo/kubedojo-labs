#!/bin/bash
if [ ! -f /root/io-benchmark.txt ]; then
  echo "FAIL: /root/io-benchmark.txt not found"
  exit 1
fi

if grep -qiE '(MB|GB|bytes|KB)/s' /root/io-benchmark.txt; then
  echo "PASS: io-benchmark.txt contains throughput measurement"
  exit 0
else
  echo "FAIL: io-benchmark.txt should contain throughput (MB/s or similar)"
  exit 1
fi
