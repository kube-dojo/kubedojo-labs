#!/bin/bash
if [ ! -f /root/kube-bench-results.txt ] || [ ! -s /root/kube-bench-results.txt ]; then
  echo "FAIL: /root/kube-bench-results.txt missing or empty"
  exit 1
fi
if [ ! -f /root/kube-bench-fails.txt ] || [ ! -s /root/kube-bench-fails.txt ]; then
  echo "FAIL: /root/kube-bench-fails.txt missing or empty"
  exit 1
fi
if [ ! -f /root/kube-bench-passes.txt ] || [ ! -s /root/kube-bench-passes.txt ]; then
  echo "FAIL: /root/kube-bench-passes.txt missing or empty"
  exit 1
fi
echo "PASS"
exit 0
