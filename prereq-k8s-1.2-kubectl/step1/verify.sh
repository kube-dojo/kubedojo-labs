#!/bin/bash
# Verify file exists and contains coredns (a key kube-system pod)
[ -f /root/kube-system-pods.txt ] || exit 1
grep -q "coredns" /root/kube-system-pods.txt 2>/dev/null || exit 1
exit 0
